from rest_framework import generics, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from store.models import CartOrder, Notification, Product, Wishlist
from store.serializers import CartOrderSerializer, NotificationSerializer, WishlistSerializer
from userauths.models import Profile, User
from userauths.serializers import ProfileSerializer


class OrdersAPIView(generics.ListAPIView):
    serializer_class = CartOrderSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        user_id = self.kwargs["user_id"]
        user = User.objects.get(id=user_id)

        orders = CartOrder.objects.filter(buyer=user, payment_status="paid")
        return orders


class OrdersDetailAPIView(generics.RetrieveAPIView):
    serializer_class = CartOrderSerializer
    permission_classes = (AllowAny,)
    lookup_field = "user_id"

    def get_object(self):
        user_id = self.kwargs["user_id"]
        order_oid = self.kwargs["order_oid"]

        user = User.objects.get(id=user_id)

        order = CartOrder.objects.get(buyer=user, payment_status="paid", oid=order_oid)
        return order


class WishlistCreateAPIView(generics.CreateAPIView):
    serializer_class = WishlistSerializer
    permission_classes = (AllowAny,)

    def create(self, request):
        payload = request.data

        product_id = payload["product_id"]
        user_id = payload["user_id"]

        product = Product.objects.get(id=product_id)
        user = User.objects.get(id=user_id)

        wishlist = Wishlist.objects.filter(product=product, user=user)
        if wishlist:
            wishlist.delete()
            return Response({"message": "Removed From Wishlist"}, status=status.HTTP_200_OK)
        else:
            wishlist = Wishlist.objects.create(
                product=product,
                user=user,
            )
            return Response({"message": "Added To Wishlist"}, status=status.HTTP_201_CREATED)


class WishlistAPIView(generics.ListAPIView):
    serializer_class = WishlistSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        user_id = self.kwargs["user_id"]
        user = User.objects.get(id=user_id)
        wishlist = Wishlist.objects.filter(
            user=user,
        )
        return wishlist


class CustomerNotificationView(generics.ListAPIView):
    serializer_class = NotificationSerializer
    permission_classes = (AllowAny,)

    def get_queryset(self):
        user_id = self.kwargs["user_id"]
        user = User.objects.get(id=user_id)
        return Notification.objects.filter(user=user).order_by("-date")


class CustomerUpdateView(generics.RetrieveUpdateAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = (AllowAny,)
