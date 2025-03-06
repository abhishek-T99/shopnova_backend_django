from decimal import Decimal

import requests
import stripe
from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.db import transaction
from django.db.models import Q
from django.shortcuts import get_object_or_404, redirect
from django.template.loader import render_to_string
from rest_framework import generics, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from addon.models import ConfigSettings, Tax
from store.models import Brand, Cart, CartOrder, CartOrderItem, Category, Coupon, Notification, Product, Review
from store.serializers import (
    BrandSerializer,
    CartOrderSerializer,
    CartSerializer,
    CategorySerializer,
    ConfigSettingsSerializer,
    ProductSerializer,
    ReviewSerializer,
)
from userauths.models import User

stripe.api_key = settings.STRIPE_SECRET_KEY
PAYPAL_CLIENT_ID = settings.PAYPAL_CLIENT_ID
PAYPAL_SECRET_ID = settings.PAYPAL_SECRET_ID


def send_notification(user=None, vendor=None, order=None, order_item=None):
    Notification.objects.create(
        user=user,
        vendor=vendor,
        order=order,
        order_item=order_item,
    )


class ConfigSettingsDetailView(generics.RetrieveAPIView):
    serializer_class = ConfigSettingsSerializer

    def get_object(self):

        return ConfigSettings.objects.first()

    permission_classes = (AllowAny,)


class CategoryListView(generics.ListAPIView):
    serializer_class = CategorySerializer
    queryset = Category.objects.filter(active=True)
    permission_classes = (AllowAny,)


class BrandListView(generics.ListAPIView):
    serializer_class = BrandSerializer
    queryset = Brand.objects.filter(active=True)
    permission_classes = (AllowAny,)


class FeaturedProductListView(generics.ListAPIView):
    serializer_class = ProductSerializer
    queryset = Product.objects.filter(status="published", featured=True)[:3]
    permission_classes = (AllowAny,)


class ProductListView(generics.ListAPIView):
    serializer_class = ProductSerializer
    queryset = Product.objects.filter(status="published")
    permission_classes = (AllowAny,)


class ProductDetailView(generics.RetrieveAPIView):
    serializer_class = ProductSerializer

    def get_object(self):

        slug = self.kwargs.get("slug")
        return Product.objects.get(slug=slug)


class CartApiView(generics.ListCreateAPIView):
    serializer_class = CartSerializer
    queryset = Cart.objects.all()
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        payload = request.data

        product_id = payload["product"]
        user_id = payload["user"]
        qty = payload["qty"]
        price = payload["price"]
        shipping_amount = payload["shipping_amount"]
        country = payload["country"]
        size = payload["size"]
        color = payload["color"]
        cart_id = payload["cart_id"]

        product = Product.objects.filter(status="published", id=product_id).first()
        if user_id != "undefined":
            user = User.objects.filter(id=user_id).first()
        else:
            user = None

        tax = Tax.objects.filter(country=country).first()
        if tax:
            tax_rate = tax.rate / 100

        else:
            tax_rate = 0

        cart = Cart.objects.filter(cart_id=cart_id, product=product).first()

        if cart:
            cart.product = product
            cart.user = user
            cart.qty = qty
            cart.price = price
            cart.sub_total = round(Decimal(price) * int(qty), 2)
            cart.shipping_amount = round(Decimal(shipping_amount) * int(qty), 2)
            cart.size = size
            cart.tax_fee = round(Decimal(cart.sub_total) * Decimal(tax_rate), 2)
            cart.color = color
            cart.country = country
            cart.cart_id = cart_id

            config_settings = ConfigSettings.objects.first()

            if config_settings.service_fee_charge_type == "percentage":
                service_fee_percentage = config_settings.service_fee_percentage / 100
                cart.service_fee = round(Decimal(service_fee_percentage) * cart.sub_total, 2)
            else:
                cart.service_fee = round(config_settings.service_fee_flat_rate, 2)

            cart.total = cart.sub_total + cart.shipping_amount + cart.service_fee + cart.tax_fee
            cart.save()

            return Response({"message": "Cart updated successfully"}, status=status.HTTP_200_OK)
        else:
            cart = Cart()
            cart.product = product
            cart.user = user
            cart.qty = qty
            cart.price = price
            cart.sub_total = round(Decimal(price) * int(qty), 2)
            cart.shipping_amount = round(Decimal(shipping_amount) * int(qty), 2)
            cart.size = size
            cart.tax_fee = round(Decimal(cart.sub_total) * Decimal(tax_rate), 2)
            cart.color = color
            cart.country = country
            cart.cart_id = cart_id

            config_settings = ConfigSettings.objects.first()

            if config_settings.service_fee_charge_type == "percentage":
                service_fee_percentage = config_settings.service_fee_percentage / 100
                cart.service_fee = round(Decimal(service_fee_percentage) * cart.sub_total, 2)
            else:
                cart.service_fee = round(config_settings.service_fee_flat_rate, 2)

            cart.total = cart.sub_total + cart.shipping_amount + cart.service_fee + cart.tax_fee
            cart.save()

            return Response({"message": "Cart Created Successfully"}, status=status.HTTP_201_CREATED)


class CartListView(generics.ListAPIView):
    serializer_class = CartSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        cart_id = self.kwargs["cart_id"]
        user_id = self.kwargs.get("user_id")

        if user_id is not None:
            user = User.objects.get(id=user_id)
            queryset = Cart.objects.filter(Q(user=user, cart_id=cart_id) | Q(user=user))
        else:
            queryset = Cart.objects.filter(cart_id=cart_id)

        return queryset


class CartTotalView(generics.ListAPIView):
    serializer_class = CartSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        cart_id = self.kwargs["cart_id"]
        user_id = self.kwargs.get("user_id")

        if user_id is not None:
            user = User.objects.get(id=user_id)
            queryset = Cart.objects.filter(cart_id=cart_id, user=user)
        else:
            queryset = Cart.objects.filter(cart_id=cart_id)

        return queryset


class CartDetailView(generics.RetrieveAPIView):

    serializer_class = CartSerializer

    lookup_field = "cart_id"

    permission_classes = (AllowAny,)

    def get_queryset(self):

        cart_id = self.kwargs["cart_id"]
        user_id = self.kwargs.get("user_id")

        if user_id is not None:

            user = User.objects.get(id=user_id)
            queryset = Cart.objects.filter(cart_id=cart_id, user=user)
        else:

            queryset = Cart.objects.filter(cart_id=cart_id)

        return queryset

    def get(self, request, *args, **kwargs):

        queryset = self.get_queryset()

        total_shipping = 0.0
        total_tax = 0.0
        total_service_fee = 0.0
        total_sub_total = 0.0
        total_total = 0.0

        for cart_item in queryset:

            total_shipping += float(self.calculate_shipping(cart_item))
            total_tax += float(self.calculate_tax(cart_item))
            total_service_fee += float(self.calculate_service_fee(cart_item))
            total_sub_total += float(self.calculate_sub_total(cart_item))
            total_total += round(float(self.calculate_total(cart_item)), 2)

        data = {
            "shipping": round(total_shipping, 2),
            "tax": total_tax,
            "service_fee": total_service_fee,
            "sub_total": total_sub_total,
            "total": total_total,
        }

        return Response(data)

    def calculate_shipping(self, cart_item):

        return cart_item.shipping_amount

    def calculate_tax(self, cart_item):

        return cart_item.tax_fee

    def calculate_service_fee(self, cart_item):

        return cart_item.service_fee

    def calculate_sub_total(self, cart_item):

        return cart_item.sub_total

    def calculate_total(self, cart_item):

        return cart_item.total


class CartItemDeleteView(generics.DestroyAPIView):
    serializer_class = CartSerializer
    lookup_field = "cart_id"

    def get_object(self):
        cart_id = self.kwargs["cart_id"]
        item_id = self.kwargs["item_id"]
        user_id = self.kwargs.get("user_id")

        if user_id is not None:
            user = get_object_or_404(User, id=user_id)
            cart = get_object_or_404(Cart, cart_id=cart_id, id=item_id, user=user)
        else:
            cart = get_object_or_404(Cart, cart_id=cart_id, id=item_id)

        return cart


class CreateOrderView(generics.CreateAPIView):
    serializer_class = CartOrderSerializer
    queryset = CartOrder.objects.all()
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        payload = request.data

        full_name = payload["full_name"]
        email = payload["email"]
        mobile = payload["mobile"]
        address = payload["address"]
        city = payload["city"]
        state = payload["state"]
        country = payload["country"]
        cart_id = payload["cart_id"]
        user_id = payload["user_id"]

        print("user_id ===============", user_id)

        if user_id != 0:
            user = User.objects.filter(id=user_id).first()
        else:
            user = None

        cart_items = Cart.objects.filter(cart_id=cart_id)

        total_shipping = Decimal(0.0)
        total_tax = Decimal(0.0)
        total_service_fee = Decimal(0.0)
        total_sub_total = Decimal(0.0)
        total_initial_total = Decimal(0.0)
        total_total = Decimal(0.0)

        with transaction.atomic():

            order = CartOrder.objects.create(
                buyer=user,
                payment_status="processing",
                full_name=full_name,
                email=email,
                mobile=mobile,
                address=address,
                city=city,
                state=state,
                country=country,
            )

            for c in cart_items:
                CartOrderItem.objects.create(
                    order=order,
                    product=c.product,
                    qty=c.qty,
                    color=c.color,
                    size=c.size,
                    price=c.price,
                    sub_total=c.sub_total,
                    shipping_amount=c.shipping_amount,
                    tax_fee=c.tax_fee,
                    service_fee=c.service_fee,
                    total=c.total,
                    initial_total=c.total,
                    vendor=c.product.vendor,
                )

                total_shipping += Decimal(c.shipping_amount)
                total_tax += Decimal(c.tax_fee)
                total_service_fee += Decimal(c.service_fee)
                total_sub_total += Decimal(c.sub_total)
                total_initial_total += Decimal(c.total)
                total_total += Decimal(c.total)

                order.vendor.add(c.product.vendor)

            order.sub_total = total_sub_total
            order.shipping_amount = total_shipping
            order.tax_fee = total_tax
            order.service_fee = total_service_fee
            order.initial_total = total_initial_total
            order.total = total_total

            order.save()

        return Response(
            {"message": "Order Created Successfully", "order_oid": order.oid}, status=status.HTTP_201_CREATED
        )


class CheckoutView(generics.RetrieveAPIView):
    serializer_class = CartOrderSerializer
    lookup_field = "order_oid"

    def get_object(self):
        order_oid = self.kwargs["order_oid"]
        cart = get_object_or_404(CartOrder, oid=order_oid)
        return cart


class CouponApiView(generics.CreateAPIView):
    serializer_class = CartOrderSerializer

    def create(self, request, *args, **kwargs):
        payload = request.data

        order_oid = payload["order_oid"]
        coupon_code = payload["coupon_code"]
        print("order_oid =======", order_oid)
        print("coupon_code =======", coupon_code)

        order = CartOrder.objects.get(oid=order_oid)
        coupon = Coupon.objects.filter(code__iexact=coupon_code, active=True).first()

        if coupon:
            order_items = CartOrderItem.objects.filter(order=order, vendor=coupon.vendor)
            if order_items:
                for i in order_items:
                    print("order_items =====", i.product.title)
                    if coupon not in i.coupon.all():
                        discount = i.total * coupon.discount / 100

                        i.total -= discount
                        i.sub_total -= discount
                        i.coupon.add(coupon)
                        i.saved += discount
                        i.applied_coupon = True

                        order.total -= discount
                        order.sub_total -= discount
                        order.saved += discount

                        i.save()
                        order.save()
                        return Response({"message": "Coupon Activated"}, status=status.HTTP_200_OK)
                    else:
                        return Response({"message": "Coupon Already Activated"}, status=status.HTTP_200_OK)
            return Response({"message": "Order Item Does Not Exists"}, status=status.HTTP_200_OK)
        else:
            return Response({"message": "Coupon Does Not Exists"}, status=status.HTTP_404_NOT_FOUND)


class StripeCheckoutView(generics.CreateAPIView):
    serializer_class = CartOrderSerializer

    def create(self, request, *args, **kwargs):
        order_oid = self.kwargs["order_oid"]
        order = CartOrder.objects.filter(oid=order_oid).first()

        if not order:
            return Response({"error": "Order not found"}, status=status.HTTP_404_NOT_FOUND)

        try:
            checkout_session = stripe.checkout.Session.create(
                customer_email=order.email,
                payment_method_types=["card"],
                line_items=[
                    {
                        "price_data": {
                            "currency": "usd",
                            "product_data": {
                                "name": order.full_name,
                            },
                            "unit_amount": int(order.total * 100),
                        },
                        "quantity": 1,
                    }
                ],
                mode="payment",
                success_url=settings.SITE_URL + "/payment-success/" + order.oid + "?session_id={CHECKOUT_SESSION_ID}",
                cancel_url=settings.SITE_URL + "/?session_id={CHECKOUT_SESSION_ID}",
            )
            order.stripe_session_id = checkout_session.id
            order.save()

            return redirect(checkout_session.url)
        except stripe.error.StripeError as e:
            return Response(
                {"error": f"Something went wrong when creating stripe checkout session: {str(e)}"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


def get_access_token(client_id, secret_key):

    token_url = "https://api.sandbox.paypal.com/v1/oauth2/token"
    data = {"grant_type": "client_credentials"}
    auth = (client_id, secret_key)
    response = requests.post(token_url, data=data, auth=auth)

    if response.status_code == 200:
        print("access_token ====", response.json()["access_token"])
        return response.json()["access_token"]
    else:
        raise Exception(f"Failed to get access token from PayPal. Status code: {response.status_code}")


class PaymentSuccessView(generics.CreateAPIView):
    serializer_class = CartOrderSerializer
    queryset = CartOrder.objects.all()

    def create(self, request, *args, **kwargs):
        payload = request.data

        order_oid = payload["order_oid"]
        session_id = payload["session_id"]
        payapl_order_id = payload["payapl_order_id"]

        order = CartOrder.objects.get(oid=order_oid)
        order_items = CartOrderItem.objects.filter(order=order)

        if payapl_order_id != "null":
            paypal_api_url = f"https://api-m.sandbox.paypal.com/v2/checkout/orders/{payapl_order_id}"
            headers = {
                "Content-Type": "application/json",
                "Authorization": f"Bearer {get_access_token(PAYPAL_CLIENT_ID, PAYPAL_SECRET_ID)}",
            }
            response = requests.get(paypal_api_url, headers=headers)

            if response.status_code == 200:
                paypal_order_data = response.json()
                paypal_payment_status = paypal_order_data["status"]
                if paypal_payment_status == "COMPLETED":
                    if order.payment_status == "processing":
                        order.payment_status = "paid"
                        order.save()
                        if order.buyer is not None:
                            send_notification(user=order.buyer, order=order)

                        merge_data = {
                            "order": order,
                            "order_items": order_items,
                        }
                        subject = "Order Placed Successfully"
                        text_body = render_to_string("email/customer_order_confirmation.txt", merge_data)
                        html_body = render_to_string("email/customer_order_confirmation.html", merge_data)

                        msg = EmailMultiAlternatives(
                            subject=subject, from_email=settings.SENDER_EMAIL, to=[order.email], body=text_body
                        )
                        msg.attach_alternative(html_body, "text/html")
                        msg.send()

                        for o in order_items:
                            send_notification(vendor=o.vendor, order=order, order_item=o)

                            merge_data = {
                                "order": order,
                                "order_items": order_items,
                            }
                            subject = "New Sale!"
                            text_body = render_to_string("email/vendor_order_sale.txt", merge_data)
                            html_body = render_to_string("email/vendor_order_sale.html", merge_data)

                            msg = EmailMultiAlternatives(
                                subject=subject,
                                from_email=settings.SENDER_EMAIL,
                                to=[o.vendor.email],
                                body=text_body,
                            )
                            msg.attach_alternative(html_body, "text/html")
                            msg.send()

                        return Response({"message": "Payment Successfull"}, status=status.HTTP_201_CREATED)
                    else:

                        return Response({"message": "Already Paid"}, status=status.HTTP_201_CREATED)

        if session_id != "null":
            session = stripe.checkout.Session.retrieve(session_id)

            if session.payment_status == "paid":
                if order.payment_status == "processing":
                    order.payment_status = "paid"
                    order.save()

                    if order.buyer is not None:
                        send_notification(user=order.buyer, order=order)
                    for o in order_items:
                        send_notification(vendor=o.vendor, order=order, order_item=o)

                    merge_data = {
                        "order": order,
                        "order_items": order_items,
                    }
                    subject = "Order Placed Successfully"

                    text_body = render_to_string("email/customer_order_confirmation.txt", merge_data)
                    html_body = render_to_string("email/customer_order_confirmation.html", merge_data)

                    msg = EmailMultiAlternatives(
                        subject=subject, from_email=settings.SENDER_EMAIL, to=[order.email], body=text_body
                    )
                    msg.attach_alternative(html_body, "text/html")
                    msg.send()

                    return Response({"message": "Payment Successfull"}, status=status.HTTP_201_CREATED)
                else:
                    return Response({"message": "Already Paid"}, status=status.HTTP_201_CREATED)

            elif session.payment_status == "unpaid":
                return Response({"message": "unpaid!"}, status=status.HTTP_402_PAYMENT_REQUIRED)
            elif session.payment_status == "canceled":
                return Response({"message": "cancelled!"}, status=status.HTTP_403_FORBIDDEN)
            else:
                return Response({"message": "An Error Occured!"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            session = None


class ReviewRatingAPIView(generics.CreateAPIView):
    serializer_class = ReviewSerializer
    queryset = Review.objects.all()
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        payload = request.data

        user_id = payload["user_id"]
        product_id = payload["product_id"]
        rating = payload["rating"]
        review = payload["review"]

        user = User.objects.get(id=user_id)
        product = Product.objects.get(id=product_id)

        Review.objects.create(user=user, product=product, rating=rating, review=review)

        return Response({"message": "Review Created Successfully."}, status=status.HTTP_201_CREATED)


class ReviewListView(generics.ListAPIView):
    serializer_class = ReviewSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        product_id = self.kwargs["product_id"]

        product = Product.objects.get(id=product_id)
        reviews = Review.objects.filter(product=product)
        return reviews


class SearchProductsAPIView(generics.ListAPIView):
    serializer_class = ProductSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        query = self.request.GET.get("query")
        print("query =======", query)

        products = Product.objects.filter(status="published", title__icontains=query)
        return products
