from rest_framework import serializers

from addon.models import ConfigSettings
from store.models import (
    Address,
    Brand,
    CancelledOrder,
    Cart,
    CartOrder,
    CartOrderItem,
    Category,
    Color,
    Coupon,
    CouponUsers,
    DeliveryCouriers,
    Gallery,
    Notification,
    Product,
    ProductFaq,
    Review,
    Size,
    Specification,
    Tag,
    Vendor,
    Wishlist,
)
from userauths.serializers import ProfileSerializer, UserSerializer


class ConfigSettingsSerializer(serializers.ModelSerializer):

    class Meta:
        model = ConfigSettings
        fields = "__all__"


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = "__all__"


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = "__all__"


class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = "__all__"


class GallerySerializer(serializers.ModelSerializer):

    class Meta:
        model = Gallery
        fields = "__all__"


class SpecificationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Specification
        fields = "__all__"


class SizeSerializer(serializers.ModelSerializer):

    class Meta:
        model = Size
        fields = "__all__"


class ColorSerializer(serializers.ModelSerializer):

    class Meta:
        model = Color
        fields = "__all__"


class ProductSerializer(serializers.ModelSerializer):

    gallery = GallerySerializer(many=True, read_only=True)
    color = ColorSerializer(many=True, read_only=True)
    size = SizeSerializer(many=True, read_only=True)
    specification = SpecificationSerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = [
            "id",
            "title",
            "image",
            "description",
            "category",
            "tags",
            "brand",
            "price",
            "old_price",
            "shipping_amount",
            "stock_qty",
            "in_stock",
            "status",
            "type",
            "featured",
            "hot_deal",
            "special_offer",
            "digital",
            "views",
            "orders",
            "saved",
            "vendor",
            "sku",
            "pid",
            "slug",
            "date",
            "gallery",
            "specification",
            "size",
            "color",
            "product_rating",
            "rating_count",
            "order_count",
            "get_precentage",
        ]

    def __init__(self, *args, **kwargs):
        super(ProductSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class ProductFaqSerializer(serializers.ModelSerializer):

    product = ProductSerializer()

    class Meta:
        model = ProductFaq
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(ProductFaqSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class CartSerializer(serializers.ModelSerializer):

    product = ProductSerializer()

    class Meta:
        model = Cart
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(CartSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class CartOrderItemSerializer(serializers.ModelSerializer):

    class Meta:
        model = CartOrderItem
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(CartOrderItemSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class CartOrderSerializer(serializers.ModelSerializer):

    orderitem = CartOrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = CartOrder
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(CartOrderSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class VendorSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)

    class Meta:
        model = Vendor
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(VendorSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class ReviewSerializer(serializers.ModelSerializer):

    product = ProductSerializer()
    profile = ProfileSerializer()

    class Meta:
        model = Review
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(ReviewSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class WishlistSerializer(serializers.ModelSerializer):

    product = ProductSerializer()

    class Meta:
        model = Wishlist
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(WishlistSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class AddressSerializer(serializers.ModelSerializer):

    class Meta:
        model = Address
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(AddressSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class CancelledOrderSerializer(serializers.ModelSerializer):

    class Meta:
        model = CancelledOrder
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(CancelledOrderSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class CouponSerializer(serializers.ModelSerializer):

    class Meta:
        model = Coupon
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(CouponSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class CouponUsersSerializer(serializers.ModelSerializer):

    coupon = CouponSerializer()

    class Meta:
        model = CouponUsers
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(CouponUsersSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class DeliveryCouriersSerializer(serializers.ModelSerializer):

    class Meta:
        model = DeliveryCouriers
        fields = "__all__"


class NotificationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Notification
        fields = "__all__"

    def __init__(self, *args, **kwargs):
        super(NotificationSerializer, self).__init__(*args, **kwargs)

        request = self.context.get("request")
        if request and request.method == "POST":

            self.Meta.depth = 0
        else:

            self.Meta.depth = 3


class SummarySerializer(serializers.Serializer):
    products = serializers.IntegerField()
    orders = serializers.IntegerField()
    revenue = serializers.DecimalField(max_digits=10, decimal_places=2)


class EarningSummarySerializer(serializers.Serializer):
    monthly_revenue = serializers.DecimalField(max_digits=10, decimal_places=2)
    total_revenue = serializers.DecimalField(max_digits=10, decimal_places=2)


class CouponSummarySerializer(serializers.Serializer):
    total_coupons = serializers.IntegerField(default=0)
    active_coupons = serializers.IntegerField(default=0)


class NotificationSummarySerializer(serializers.Serializer):
    un_read_noti = serializers.IntegerField(default=0)
    read_noti = serializers.IntegerField(default=0)
    all_noti = serializers.IntegerField(default=0)
