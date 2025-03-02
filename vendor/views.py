from datetime import datetime, timedelta

from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.db import models, transaction
from django.db.models.functions import ExtractMonth
from django.template.loader import render_to_string
from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from store.models import CartOrder, CartOrderItem, Coupon, DeliveryCouriers, Notification, Product, Review
from store.serializers import (
    CartOrderItemSerializer,
    CartOrderSerializer,
    ColorSerializer,
    CouponSerializer,
    CouponSummarySerializer,
    DeliveryCouriersSerializer,
    EarningSummarySerializer,
    GallerySerializer,
    NotificationSerializer,
    NotificationSummarySerializer,
    ProductSerializer,
    ReviewSerializer,
    SizeSerializer,
    SpecificationSerializer,
    SummarySerializer,
    VendorSerializer,
)
from userauths.models import Profile
from userauths.serializers import ProfileSerializer
from vendor.models import Vendor


class DashboardStatsAPIView(generics.ListAPIView):
    serializer_class = SummarySerializer

    def get_queryset(self):

        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)

        # Calculate summary values
        product_count = Product.objects.filter(vendor=vendor).count()
        order_count = CartOrder.objects.filter(vendor=vendor, payment_status="paid").count()
        revenue = (
            CartOrderItem.objects.filter(vendor=vendor, order__payment_status="paid").aggregate(
                total_revenue=models.Sum(models.F("sub_total") + models.F("shipping_amount"))
            )["total_revenue"]
            or 0
        )

        # Return a dummy list as we only need one summary object
        return [{"products": product_count, "orders": order_count, "revenue": revenue}]

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class ProductsAPIView(generics.ListAPIView):
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        products = Product.objects.filter(vendor=vendor)
        return products


class OrdersAPIView(generics.ListAPIView):
    serializer_class = CartOrderSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        orders = CartOrder.objects.filter(vendor=vendor, payment_status="paid")
        return orders


class RevenueAPIView(generics.ListAPIView):
    serializer_class = CartOrderItemSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        revenue = (
            CartOrderItem.objects.filter(vendor=vendor, order__payment_status="paid").aggregate(
                total_revenue=models.Sum(models.F("sub_total") + models.F("shipping_amount"))
            )["total_revenue"]
            or 0
        )
        return revenue


class YearlyOrderReportChartAPIView(generics.ListAPIView):
    serializer_class = CartOrderItemSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)

        # Include the 'product' field in the queryset
        report = (
            CartOrderItem.objects.filter(vendor=vendor, order__payment_status="paid")
            .select_related("product")
            .values("order__date", "product")
            .annotate(models.Count("id"))
        )

        return report


@api_view(("GET",))
def MonthlyOrderChartAPIFBV(request, vendor_id):
    vendor = Vendor.objects.get(id=vendor_id)
    orders = CartOrder.objects.filter(vendor=vendor)
    orders_by_month = (
        orders.annotate(month=ExtractMonth("date"))
        .values("month")
        .annotate(orders=models.Count("id"))
        .order_by("month")
    )
    return Response(orders_by_month)


@api_view(("GET",))
def MonthlyProductsChartAPIFBV(request, vendor_id):
    vendor = Vendor.objects.get(id=vendor_id)
    products = Product.objects.filter(vendor=vendor)
    products_by_month = (
        products.annotate(month=ExtractMonth("date"))
        .values("month")
        .annotate(orders=models.Count("id"))
        .order_by("month")
    )
    return Response(products_by_month)


class ProductCreateView(generics.CreateAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    @transaction.atomic
    def perform_create(self, serializer):
        serializer.is_valid(raise_exception=True)
        serializer.save()
        product_instance = serializer.instance

        specifications_data = []
        colors_data = []
        sizes_data = []
        gallery_data = []
        # Loop through the keys of self.request.data
        for key, value in self.request.data.items():
            # Example key: specifications[0][title]
            if key.startswith("specifications") and "[title]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                title = value
                content_key = f"specifications[{index}][content]"
                content = self.request.data.get(content_key)
                specifications_data.append({"title": title, "content": content})

            # Example key: colors[0][name]
            elif key.startswith("colors") and "[name]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                name = value
                color_code_key = f"colors[{index}][color_code]"
                color_code = self.request.data.get(color_code_key)
                image_key = f"colors[{index}][image]"
                image = self.request.data.get(image_key)
                colors_data.append({"name": name, "color_code": color_code, "image": image})

            # Example key: sizes[0][name]
            elif key.startswith("sizes") and "[name]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                name = value
                price_key = f"sizes[{index}][price]"
                price = self.request.data.get(price_key)
                sizes_data.append({"name": name, "price": price})

            # Example key: gallery[0][image]
            elif key.startswith("gallery") and "[image]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                image = value
                gallery_data.append({"image": image})

        # Log or print the data for debugging
        print("specifications_data:", specifications_data)
        print("colors_data:", colors_data)
        print("sizes_data:", sizes_data)
        print("gallery_data:", gallery_data)

        # Save nested serializers with the product instance
        self.save_nested_data(product_instance, SpecificationSerializer, specifications_data)
        self.save_nested_data(product_instance, ColorSerializer, colors_data)
        self.save_nested_data(product_instance, SizeSerializer, sizes_data)
        self.save_nested_data(product_instance, GallerySerializer, gallery_data)

    def save_nested_data(self, product_instance, serializer_class, data):
        serializer = serializer_class(data=data, many=True, context={"product_instance": product_instance})
        serializer.is_valid(raise_exception=True)
        serializer.save(product=product_instance)


class ProductUpdateAPIView(generics.RetrieveUpdateAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_id = self.kwargs["vendor_id"]
        product_pid = self.kwargs["product_pid"]

        vendor = Vendor.objects.get(id=vendor_id)
        product = Product.objects.get(vendor=vendor, pid=product_pid)
        return product

    @transaction.atomic
    def update(self, request, *args, **kwargs):
        product = self.get_object()

        # Deserialize product data
        serializer = self.get_serializer(product, data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        # Delete all existing nested data
        product.specification().delete()
        product.color().delete()
        product.size().delete()
        product.gallery().delete()

        specifications_data = []
        colors_data = []
        sizes_data = []
        gallery_data = []
        # Loop through the keys of self.request.data
        for key, value in self.request.data.items():
            # Example key: specifications[0][title]
            if key.startswith("specifications") and "[title]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                title = value
                content_key = f"specifications[{index}][content]"
                content = self.request.data.get(content_key)
                specifications_data.append({"title": title, "content": content})

            # Example key: colors[0][name]
            elif key.startswith("colors") and "[name]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                name = value
                color_code_key = f"colors[{index}][color_code]"
                color_code = self.request.data.get(color_code_key)
                image_key = f"colors[{index}][image]"
                image = self.request.data.get(image_key)
                colors_data.append({"name": name, "color_code": color_code, "image": image})

            # Example key: sizes[0][name]
            elif key.startswith("sizes") and "[name]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                name = value
                price_key = f"sizes[{index}][price]"
                price = self.request.data.get(price_key)
                sizes_data.append({"name": name, "price": price})

            # Example key: gallery[0][image]
            elif key.startswith("gallery") and "[image]" in key:
                # Extract index from key
                index = key.split("[")[1].split("]")[0]
                image = value
                gallery_data.append({"image": image})

        # Log or print the data for debugging
        print("specifications_data:", specifications_data)
        print("colors_data:", colors_data)
        print("sizes_data:", sizes_data)
        print("gallery_data:", gallery_data)

        # Save nested serializers with the product instance
        self.save_nested_data(product, SpecificationSerializer, specifications_data)
        self.save_nested_data(product, ColorSerializer, colors_data)
        self.save_nested_data(product, SizeSerializer, sizes_data)
        self.save_nested_data(product, GallerySerializer, gallery_data)

        return Response({"message": "Product Updated"}, status=status.HTTP_200_OK)

    def save_nested_data(self, product_instance, serializer_class, data):
        serializer = serializer_class(data=data, many=True, context={"product_instance": product_instance})
        serializer.is_valid(raise_exception=True)
        serializer.save(product=product_instance)


class ProductDeleteAPIView(generics.DestroyAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_id = self.kwargs["vendor_id"]
        product_pid = self.kwargs["product_pid"]

        vendor = Vendor.objects.get(id=vendor_id)
        product = Product.objects.get(vendor=vendor, pid=product_pid)
        return product


class FilterProductsAPIView(generics.ListAPIView):
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        filter = self.request.GET.get("filter")

        print("filter =======", filter)

        vendor = Vendor.objects.get(id=vendor_id)
        if filter == "published":
            products = Product.objects.filter(vendor=vendor, status="published")
        elif filter == "draft":
            products = Product.objects.filter(vendor=vendor, status="draft")
        elif filter == "disabled":
            products = Product.objects.filter(vendor=vendor, status="disabled")
        elif filter == "in-review":
            products = Product.objects.filter(vendor=vendor, status="in-review")
        elif filter == "latest":
            products = Product.objects.filter(vendor=vendor).order_by("-id")
        elif filter == "oldest":
            products = Product.objects.filter(vendor=vendor).order_by("id")
        else:
            products = Product.objects.filter(vendor=vendor)
        return products


class OrderDetailAPIView(generics.RetrieveAPIView):
    serializer_class = CartOrderSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_id = self.kwargs["vendor_id"]
        order_oid = self.kwargs["order_oid"]

        vendor = Vendor.objects.get(id=vendor_id)
        order = CartOrder.objects.get(vendor=vendor, payment_status="paid", oid=order_oid)
        return order


class Earning(generics.ListAPIView):
    serializer_class = EarningSummarySerializer

    def get_queryset(self):

        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)

        one_month_ago = datetime.today() - timedelta(days=28)
        monthly_revenue = (
            CartOrderItem.objects.filter(
                vendor=vendor, order__payment_status="paid", date__gte=one_month_ago
            ).aggregate(total_revenue=models.Sum(models.F("sub_total") + models.F("shipping_amount")))["total_revenue"]
            or 0
        )
        total_revenue = (
            CartOrderItem.objects.filter(vendor=vendor, order__payment_status="paid").aggregate(
                total_revenue=models.Sum(models.F("sub_total") + models.F("shipping_amount"))
            )["total_revenue"]
            or 0
        )

        return [
            {
                "monthly_revenue": monthly_revenue,
                "total_revenue": total_revenue,
            }
        ]

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


@api_view(("GET",))
def MonthlyEarningTracker(request, vendor_id):
    vendor = Vendor.objects.get(id=vendor_id)
    monthly_earning_tracker = (
        CartOrderItem.objects.filter(vendor=vendor, order__payment_status="paid")
        .annotate(month=ExtractMonth("date"))
        .values("month")
        .annotate(
            sales_count=models.Sum("qty"), total_earning=models.Sum(models.F("sub_total") + models.F("shipping_amount"))
        )
        .order_by("-month")
    )
    return Response(monthly_earning_tracker)


class ReviewsListAPIView(generics.ListAPIView):
    serializer_class = ReviewSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        reviews = Review.objects.filter(product__vendor=vendor)
        return reviews


class ReviewsDetailAPIView(generics.RetrieveUpdateAPIView):
    serializer_class = ReviewSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_id = self.kwargs["vendor_id"]
        review_id = self.kwargs["review_id"]

        vendor = Vendor.objects.get(id=vendor_id)
        review = Review.objects.get(product__vendor=vendor, id=review_id)
        return review


class CouponListAPIView(generics.ListAPIView):
    serializer_class = CouponSerializer
    queryset = Coupon.objects.all()
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        coupon = Coupon.objects.filter(vendor=vendor)
        return coupon


class CouponCreateAPIView(generics.CreateAPIView):
    serializer_class = CouponSerializer
    queryset = Coupon.objects.all()
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        payload = request.data

        vendor_id = payload["vendor_id"]
        code = payload["code"]
        discount = payload["discount"]
        active = payload["active"]

        print("vendor_id ======", vendor_id)
        print("code ======", code)
        print("discount ======", discount)
        print("active ======", active)

        vendor = Vendor.objects.get(id=vendor_id)
        Coupon.objects.create(vendor=vendor, code=code, discount=discount, active=(active.lower() == "true"))

        return Response({"message": "Coupon Created Successfully."}, status=status.HTTP_201_CREATED)


class CouponDetailAPIView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = CouponSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_id = self.kwargs["vendor_id"]
        coupon_id = self.kwargs["coupon_id"]

        vendor = Vendor.objects.get(id=vendor_id)

        coupon = Coupon.objects.get(vendor=vendor, id=coupon_id)
        return coupon


class CouponStats(generics.ListAPIView):
    serializer_class = CouponSummarySerializer

    def get_queryset(self):

        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)

        total_coupons = Coupon.objects.filter(vendor=vendor).count()
        active_coupons = Coupon.objects.filter(vendor=vendor, active=True).count()

        return [
            {
                "total_coupons": total_coupons,
                "active_coupons": active_coupons,
            }
        ]

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class NotificationUnSeenListAPIView(generics.ListAPIView):
    serializer_class = NotificationSerializer
    queryset = Notification.objects.all()
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        notifications = Notification.objects.filter(vendor=vendor, seen=False).order_by("seen")
        return notifications


class NotificationSeenListAPIView(generics.ListAPIView):
    serializer_class = NotificationSerializer
    queryset = Notification.objects.all()
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        notifications = Notification.objects.filter(vendor=vendor, seen=True).order_by("seen")
        return notifications


class NotificationSummaryAPIView(generics.ListAPIView):
    serializer_class = NotificationSummarySerializer

    def get_queryset(self):
        vendor_id = self.kwargs["vendor_id"]
        vendor = Vendor.objects.get(id=vendor_id)

        un_read_noti = Notification.objects.filter(vendor=vendor, seen=False).count()
        read_noti = Notification.objects.filter(vendor=vendor, seen=True).count()
        all_noti = Notification.objects.filter(vendor=vendor).count()

        return [
            {
                "un_read_noti": un_read_noti,
                "read_noti": read_noti,
                "all_noti": all_noti,
            }
        ]

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class NotificationMarkAsSeen(generics.RetrieveUpdateAPIView):
    serializer_class = NotificationSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_id = self.kwargs["vendor_id"]
        noti_id = self.kwargs["noti_id"]
        vendor = Vendor.objects.get(id=vendor_id)
        notification = Notification.objects.get(vendor=vendor, id=noti_id)
        notification.seen = True
        notification.save()
        return notification


# LESS REDUNDANT NOTIFICATION CODE
# class NotificationAPIView(generics.ListCreateAPIView, generics.RetrieveUpdateAPIView):
#     serializer_class = NotificationSerializer
#     permission_classes = (AllowAny, )

#     def get_queryset(self):
#         vendor_id = self.kwargs['vendor_id']
#         vendor = Vendor.objects.get(id=vendor_id)

#         seen_param = self.request.query_params.get('seen', None)

#         if seen_param == 'true':
#             return Notification.objects.filter(vendor=vendor, seen=True).order_by('seen')
#         elif seen_param == 'false':
#             return Notification.objects.filter(vendor=vendor, seen=False).order_by('seen')
#         else:
#             return Notification.objects.filter(vendor=vendor).order_by('seen')

#     def list(self, request, *args, **kwargs):
#         if 'summary' in request.query_params:
#             return self.get_summary(request, *args, **kwargs)
#         return super().list(request, *args, **kwargs)

#     def get_summary(self, request, *args, **kwargs):
#         vendor_id = kwargs['vendor_id']
#         vendor = Vendor.objects.get(id=vendor_id)

#         un_read_noti = Notification.objects.filter(vendor=vendor, seen=False).count()
#         read_noti = Notification.objects.filter(vendor=vendor, seen=True).count()
#         all_noti = Notification.objects.filter(vendor=vendor).count()

#         return Response({
#             'un_read_noti': un_read_noti,
#             'read_noti': read_noti,
#             'all_noti': all_noti,
#         })

#     def perform_update(self, serializer):
#         serializer.instance.seen = True
#         serializer.save()

# Example URL patterns in urls.py:
# path('notifications/<int:vendor_id>/', NotificationAPIView.as_view(), name='notification-list'),
# path('notifications/<int:vendor_id>/<int:pk>/', NotificationAPIView.as_view(), name='notification-detail'),


class VendorProfileUpdateView(generics.RetrieveUpdateAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = (AllowAny,)
    parser_classes = (MultiPartParser, FormParser)


class ShopUpdateView(generics.RetrieveUpdateAPIView):
    queryset = Vendor.objects.all()
    serializer_class = VendorSerializer
    permission_classes = (AllowAny,)
    parser_classes = (MultiPartParser, FormParser)


class ShopAPIView(generics.RetrieveUpdateAPIView):
    queryset = Product.objects.all()
    serializer_class = VendorSerializer
    permission_classes = (AllowAny,)

    def get_object(self):
        vendor_slug = self.kwargs["vendor_slug"]

        vendor = Vendor.objects.get(slug=vendor_slug)
        return vendor


class ShopProductsAPIView(generics.ListAPIView):
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        vendor_slug = self.kwargs["vendor_slug"]
        vendor = Vendor.objects.get(slug=vendor_slug)
        products = Product.objects.filter(vendor=vendor)
        return products


class VendorRegister(generics.CreateAPIView):
    serializer_class = VendorSerializer
    queryset = Vendor.objects.all()
    permission_classes = [AllowAny]

    def create(self, request, *args, **kwargs):
        payload = request.data

        image = payload["image"]
        name = payload["name"]
        email = payload["email"]
        description = payload["description"]
        mobile = payload["mobile"]
        user_id = payload["user_id"]

        Vendor.objects.create(
            image=image,
            name=name,
            email=email,
            description=description,
            mobile=mobile,
            user_id=user_id,
        )

        return Response({"message": "Created vendor account"})


class CourierListAPIView(generics.ListAPIView):
    queryset = DeliveryCouriers.objects.all()
    serializer_class = DeliveryCouriersSerializer
    permission_classes = [AllowAny]


class OrderItemDetailAPIView(generics.RetrieveUpdateAPIView):
    serializer_class = CartOrderItemSerializer
    permission_classes = [AllowAny]
    queryset = CartOrderItem.objects.all()

    def get_object(self):
        pk = self.kwargs["pk"]
        return CartOrderItem.objects.get(id=pk)

    def update(self, request, *args, **kwargs):
        instance = self.get_object()

        instance.tracking_id = request.data.get("tracking_id", instance.tracking_id)

        delivery_couriers_id = request.data.get("delivery_couriers")
        delivery_couriers = DeliveryCouriers.objects.get(id=delivery_couriers_id)
        instance.delivery_couriers = delivery_couriers

        notify_buyer = request.data.get("notify_buyer")
        if notify_buyer == "true":
            merge_data = {
                "instance": instance,
                "tracking_id": instance.tracking_id,
                "delivery_couriers": instance.delivery_couriers.name,
                "tracking_link": f"{instance.delivery_couriers.tracking_website}?\
                    {instance.delivery_couriers.url_parameter}={instance.tracking_id}",
            }
            subject = f"Tracking ID Added for {instance.product.title}"
            text_body = render_to_string("email/tracking_id_added.txt", merge_data)
            html_body = render_to_string("email/tracking_id_added.html", merge_data)

            msg = EmailMultiAlternatives(
                subject=subject, from_email=settings.FROM_EMAIL, to=[instance.order.email], body=text_body
            )
            msg.attach_alternative(html_body, "text/html")
            msg.send()

        instance.save()

        serializer = self.get_serializer(instance)
        return Response(serializer.data, status=status.HTTP_200_OK)
