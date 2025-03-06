import shortuuid
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils import timezone
from django.utils.html import mark_safe
from django.utils.text import slugify
from shortuuid.django_fields import ShortUUIDField

from userauths.models import Profile, User, user_directory_path
from vendor.models import Vendor

DISCOUNT_TYPE = (
    ("Percentage", "Percentage"),
    ("Flat Rate", "Flat Rate"),
)

STATUS_CHOICE = (
    ("processing", "Processing"),
    ("shipped", "Shipped"),
    ("delivered", "Delivered"),
)


STATUS = (
    ("draft", "Draft"),
    ("disabled", "Disabled"),
    ("rejected", "Rejected"),
    ("in_review", "In Review"),
    ("published", "Published"),
)


PAYMENT_STATUS = (
    ("paid", "Paid"),
    ("pending", "Pending"),
    ("processing", "Processing"),
    ("cancelled", "Cancelled"),
    ("initiated", "Initiated"),
    ("failed", "failed"),
    ("refunding", "refunding"),
    ("refunded", "refunded"),
    ("unpaid", "unpaid"),
    ("expired", "expired"),
)


ORDER_STATUS = (
    ("Pending", "Pending"),
    ("Fulfilled", "Fulfilled"),
    ("Partially Fulfilled", "Partially Fulfilled"),
    ("Cancelled", "Cancelled"),
)

AUCTION_STATUS = (("on_going", "On Going"), ("finished", "finished"), ("cancelled", "cancelled"))

WIN_STATUS = (("won", "Won"), ("lost", "Lost"), ("pending", "pending"))

PRODUCT_TYPE = (("regular", "Regular"), ("auction", "Auction"), ("offer", "Offer"))

OFFER_STATUS = (
    ("accepted", "Accepted"),
    ("rejected", "Rejected"),
    ("pending", "Pending"),
)

PRODUCT_CONDITION = (
    ("new", "New"),
    ("old_2nd_hand", "“Used or 2nd Hand"),
    ("custom", "Custom"),
)

PRODUCT_CONDITION_RATING = (
    (1, "1/10"),
    (2, "2/10"),
    (3, "3/10"),
    (4, "4/10"),
    (5, "5/10"),
    (6, "6/10"),
    (7, "7/10"),
    (8, "8/10"),
    (9, "9/10"),
    (10, "10/10"),
)


DELIVERY_STATUS = (
    ("On Hold", "On Hold"),
    ("Shipping Processing", "Shipping Processing"),
    ("Shipped", "Shipped"),
    ("Arrived", "Arrived"),
    ("Delivered", "Delivered"),
    ("Returning", "Returning"),
    ("Returned", "Returned"),
)

PAYMENT_METHOD = (
    ("Paypal", "Paypal"),
    ("Credit/Debit Card", "Credit/Debit Card"),
    ("Wallet Points", "Wallet Points"),
)


RATING = (
    (1, "★☆☆☆☆"),
    (2, "★★☆☆☆"),
    (3, "★★★☆☆"),
    (4, "★★★★☆"),
    (5, "★★★★★"),
)


class Category(models.Model):

    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to=user_directory_path, default="category.jpg", null=True, blank=True)
    active = models.BooleanField(default=True)
    slug = models.SlugField(null=True, blank=True)

    class Meta:
        verbose_name_plural = "Categories"

    def thumbnail(self):
        return mark_safe(
            '<img src="%s" width="50" height="50" style="object-fit:cover; border-radius: 6px;" />' % (self.image.url)
        )

    def __str__(self):
        return self.title

    def product_count(self):
        product_count = Product.objects.filter(category=self).count()
        return product_count

    def cat_products(self):
        cat_products = Product.objects.filter(category=self)
        return cat_products

    def save(self, *args, **kwargs):
        if self.slug == "" or self.slug is None:
            uuid_key = shortuuid.uuid()
            uniqueid = uuid_key[:4]
            self.slug = slugify(self.title) + "-" + str(uniqueid.lower())
        super(Category, self).save(*args, **kwargs)


class Tag(models.Model):

    title = models.CharField(max_length=30)
    category = models.ForeignKey(Category, default="", verbose_name="Category", on_delete=models.PROTECT)
    active = models.BooleanField(default=True)
    slug = models.SlugField("Tag slug", max_length=30, null=False, blank=False, unique=True)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name_plural = "Tags"
        ordering = ("title",)


class Brand(models.Model):

    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to=user_directory_path, default="brand.jpg", null=True, blank=True)
    active = models.BooleanField(default=True)

    class Meta:
        verbose_name_plural = "Brands"

    def brand_image(self):
        return mark_safe(
            '<img src="%s" width="50" height="50" style="object-fit:cover; border-radius: 6px;" />' % (self.image.url)
        )

    def __str__(self):
        return self.title


class Product(models.Model):

    title = models.CharField(max_length=100)
    image = models.FileField(upload_to=user_directory_path, blank=True, null=True, default="product.jpg")
    description = models.TextField(null=True, blank=True)
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name="category")
    tags = models.CharField(max_length=1000, null=True, blank=True)
    brand = models.CharField(max_length=100, null=True, blank=True)

    price = models.DecimalField(max_digits=12, decimal_places=2, default=0.00, null=True, blank=True)
    old_price = models.DecimalField(max_digits=12, decimal_places=2, default=0.00, null=True, blank=True)
    shipping_amount = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)

    stock_qty = models.PositiveIntegerField(default=0)
    in_stock = models.BooleanField(default=True)

    status = models.CharField(choices=STATUS, max_length=50, default="published", null=True, blank=True)
    type = models.CharField(choices=PRODUCT_TYPE, max_length=50, default="regular")

    featured = models.BooleanField(default=False)
    hot_deal = models.BooleanField(default=False)
    special_offer = models.BooleanField(default=False)
    digital = models.BooleanField(default=False)

    views = models.PositiveIntegerField(default=0, null=True, blank=True)
    orders = models.PositiveIntegerField(default=0, null=True, blank=True)
    saved = models.PositiveIntegerField(default=0, null=True, blank=True)
    rating = models.IntegerField(default=0, null=True, blank=True)

    vendor = models.ForeignKey(Vendor, on_delete=models.SET_NULL, null=True, blank=True, related_name="vendor")

    sku = ShortUUIDField(unique=True, length=5, max_length=50, prefix="SKU", alphabet="1234567890")
    pid = ShortUUIDField(unique=True, length=10, max_length=20, alphabet="abcdefghijklmnopqrstuvxyz")

    slug = models.SlugField(null=True, blank=True)

    date = models.DateTimeField(default=timezone.now)

    class Meta:
        ordering = ["-id"]
        verbose_name_plural = "Products"

    def product_image(self):
        return mark_safe(
            '<img src="%s" width="50" height="50" style="object-fit:cover; border-radius: 6px;" />' % (self.image.url)
        )

    def __str__(self):
        return self.title

    def category_count(self):
        return Product.objects.filter(category__in=self.category).count()

    def get_precentage(self):
        new_price = ((self.old_price - self.price) / self.old_price) * 100
        return round(new_price, 0)

    def product_rating(self):
        product_rating = Review.objects.filter(product=self).aggregate(avg_rating=models.Avg("rating"))
        return product_rating["avg_rating"]

    def rating_count(self):
        rating_count = Review.objects.filter(product=self).count()
        return rating_count

    def order_count(self):
        order_count = CartOrderItem.objects.filter(product=self, order__payment_status="paid").count()
        return order_count

    def gallery(self):
        gallery = Gallery.objects.filter(product=self)
        return gallery

    def specification(self):
        return Specification.objects.filter(product=self)

    def color(self):
        return Color.objects.filter(product=self)

    def size(self):
        return Size.objects.filter(product=self)

    def frequently_bought_together(self):
        frequently_bought_together_products = (
            Product.objects.filter(order_item__order__in=CartOrder.objects.filter(orderitem__product=self))
            .exclude(id=self.id)
            .annotate(count=models.Count("id"))
            .order_by("-id")[:3]
        )
        return frequently_bought_together_products

    def save(self, *args, **kwargs):
        if self.slug == "" or self.slug is None:
            uuid_key = shortuuid.uuid()
            uniqueid = uuid_key[:4]
            self.slug = slugify(self.title) + "-" + str(uniqueid.lower())

        if self.stock_qty is not None:
            if self.stock_qty == 0:
                self.in_stock = False

            if self.stock_qty > 0:
                self.in_stock = True
        else:
            self.stock_qty = 0
            self.in_stock = False

        self.rating = self.product_rating()

        super(Product, self).save(*args, **kwargs)


class Gallery(models.Model):

    product = models.ForeignKey(Product, on_delete=models.CASCADE, null=True)
    image = models.FileField(upload_to=user_directory_path, default="gallery.jpg")
    active = models.BooleanField(default=True)
    date = models.DateTimeField(auto_now_add=True)
    gid = ShortUUIDField(length=10, max_length=25, alphabet="abcdefghijklmnopqrstuvxyz")

    class Meta:
        ordering = ["date"]
        verbose_name_plural = "Product Images"

    def __str__(self):
        return "Image"


class Specification(models.Model):

    product = models.ForeignKey(Product, on_delete=models.CASCADE, null=True)
    title = models.CharField(max_length=100, blank=True, null=True)
    content = models.CharField(max_length=1000, blank=True, null=True)


class Size(models.Model):

    product = models.ForeignKey(Product, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=100, blank=True, null=True)
    price = models.DecimalField(default=0.00, decimal_places=2, max_digits=12)


class Color(models.Model):

    product = models.ForeignKey(Product, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=100, blank=True, null=True)
    color_code = models.CharField(max_length=100, blank=True, null=True)
    image = models.FileField(upload_to=user_directory_path, blank=True, null=True)


class ProductFaq(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    pid = ShortUUIDField(unique=True, length=10, max_length=20, alphabet="abcdefghijklmnopqrstuvxyz")
    product = models.ForeignKey(Product, on_delete=models.CASCADE, null=True, related_name="product_faq")
    email = models.EmailField()
    question = models.CharField(max_length=1000)
    answer = models.CharField(max_length=10000, null=True, blank=True)
    active = models.BooleanField(default=False)
    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Product Faqs"
        ordering = ["-date"]

    def __str__(self):
        return self.question


class Cart(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    qty = models.PositiveIntegerField(default=0, null=True, blank=True)
    price = models.DecimalField(decimal_places=2, max_digits=12, default=0.00, null=True, blank=True)
    sub_total = models.DecimalField(decimal_places=2, max_digits=12, default=0.00, null=True, blank=True)
    shipping_amount = models.DecimalField(decimal_places=2, max_digits=12, default=0.00, null=True, blank=True)
    service_fee = models.DecimalField(decimal_places=2, max_digits=12, default=0.00, null=True, blank=True)
    tax_fee = models.DecimalField(decimal_places=2, max_digits=12, default=0.00, null=True, blank=True)
    total = models.DecimalField(decimal_places=2, max_digits=12, default=0.00, null=True, blank=True)
    country = models.CharField(max_length=100, null=True, blank=True)
    size = models.CharField(max_length=100, null=True, blank=True)
    color = models.CharField(max_length=100, null=True, blank=True)
    cart_id = models.CharField(max_length=1000, null=True, blank=True)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.cart_id} - {self.product.title}"


class CartOrder(models.Model):

    vendor = models.ManyToManyField(Vendor, blank=True)

    buyer = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name="buyer", blank=True)

    sub_total = models.DecimalField(default=0.00, max_digits=12, decimal_places=2)

    shipping_amount = models.DecimalField(default=0.00, max_digits=12, decimal_places=2)

    tax_fee = models.DecimalField(default=0.00, max_digits=12, decimal_places=2)

    service_fee = models.DecimalField(default=0.00, max_digits=12, decimal_places=2)

    total = models.DecimalField(default=0.00, max_digits=12, decimal_places=2)

    payment_status = models.CharField(max_length=100, choices=PAYMENT_STATUS, default="initiated")
    order_status = models.CharField(max_length=100, choices=ORDER_STATUS, default="Pending")

    initial_total = models.DecimalField(
        default=0.00, max_digits=12, decimal_places=2, help_text="The original total before discounts"
    )
    saved = models.DecimalField(
        max_digits=12, decimal_places=2, default=0.00, null=True, blank=True, help_text="Amount saved by customer"
    )

    full_name = models.CharField(max_length=1000)
    email = models.CharField(max_length=1000)
    mobile = models.CharField(max_length=1000)

    address = models.CharField(max_length=1000, null=True, blank=True)
    city = models.CharField(max_length=1000, null=True, blank=True)
    state = models.CharField(max_length=1000, null=True, blank=True)
    country = models.CharField(max_length=1000, null=True, blank=True)

    coupons = models.ManyToManyField("store.Coupon", blank=True)

    stripe_session_id = models.CharField(max_length=200, null=True, blank=True)
    oid = ShortUUIDField(length=10, max_length=25, alphabet="abcdefghijklmnopqrstuvxyz")
    date = models.DateTimeField(default=timezone.now)

    class Meta:
        ordering = ["-date"]
        verbose_name_plural = "Cart Order"

    def __str__(self):
        return self.oid

    def get_order_items(self):
        return CartOrderItem.objects.filter(order=self)


class CartOrderItem(models.Model):

    order = models.ForeignKey(CartOrder, on_delete=models.CASCADE, related_name="orderitem")

    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="order_item")

    qty = models.IntegerField(default=0)

    color = models.CharField(max_length=100, null=True, blank=True)
    size = models.CharField(max_length=100, null=True, blank=True)

    price = models.DecimalField(max_digits=12, decimal_places=2, default=0.00)
    sub_total = models.DecimalField(
        max_digits=12, decimal_places=2, default=0.00, help_text="Total of Product price * Product Qty"
    )
    shipping_amount = models.DecimalField(
        max_digits=12, decimal_places=2, default=0.00, help_text="Estimated Shipping Fee = shipping_fee * total"
    )
    tax_fee = models.DecimalField(
        default=0.00,
        max_digits=12,
        decimal_places=2,
        help_text="Estimated Vat based on delivery country = tax_rate * (total + shipping)",
    )
    service_fee = models.DecimalField(
        default=0.00,
        max_digits=12,
        decimal_places=2,
        help_text="Estimated Service Fee = service_fee * total (paid by buyer to platform)",
    )
    total = models.DecimalField(
        max_digits=12, decimal_places=2, default=0.00, help_text="Grand Total of all amount listed above"
    )

    expected_delivery_date_from = models.DateField(auto_now_add=False, null=True, blank=True)
    expected_delivery_date_to = models.DateField(auto_now_add=False, null=True, blank=True)

    initial_total = models.DecimalField(
        max_digits=12,
        decimal_places=2,
        default=0.00,
        help_text="Grand Total of all amount listed above before discount",
    )
    saved = models.DecimalField(
        max_digits=12, decimal_places=2, default=0.00, null=True, blank=True, help_text="Amount saved by customer"
    )

    order_placed = models.BooleanField(default=False)
    processing_order = models.BooleanField(default=False)
    quality_check = models.BooleanField(default=False)
    product_shipped = models.BooleanField(default=False)
    product_arrived = models.BooleanField(default=False)
    product_delivered = models.BooleanField(default=False)

    delivery_status = models.CharField(max_length=100, choices=DELIVERY_STATUS, default="On Hold")
    delivery_couriers = models.ForeignKey("store.DeliveryCouriers", on_delete=models.SET_NULL, null=True, blank=True)
    tracking_id = models.CharField(max_length=100000, null=True, blank=True)

    coupon = models.ManyToManyField("store.Coupon", blank=True)
    applied_coupon = models.BooleanField(default=False)
    oid = ShortUUIDField(length=10, max_length=25, alphabet="abcdefghijklmnopqrstuvxyz")

    vendor = models.ForeignKey(Vendor, on_delete=models.SET_NULL, null=True)
    date = models.DateTimeField(default=timezone.now)

    class Meta:
        verbose_name_plural = "Cart Order Item"
        ordering = ["-date"]

    def order_img(self):
        return mark_safe(
            '<img src="%s" width="50" height="50" style="object-fit:cover; border-radius: 6px;" />'
            % (self.product.image.url)
        )

    def order_id(self):
        return f"Order ID #{self.order.oid}"

    def __str__(self):
        return self.oid


class Review(models.Model):

    user = models.ForeignKey(User, on_delete=models.SET_NULL, blank=True, null=True)

    product = models.ForeignKey(Product, on_delete=models.SET_NULL, blank=True, null=True, related_name="reviews")

    review = models.TextField()

    reply = models.CharField(null=True, blank=True, max_length=1000)

    rating = models.IntegerField(choices=RATING, default=None)

    active = models.BooleanField(default=False)

    helpful = models.ManyToManyField(User, blank=True, related_name="helpful")
    not_helpful = models.ManyToManyField(User, blank=True, related_name="not_helpful")

    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Reviews & Rating"
        ordering = ["-date"]

    def __str__(self):
        if self.product:
            return self.product.title
        else:
            return "Review"

    def get_rating(self):
        return self.rating

    def profile(self):
        return Profile.objects.get(user=self.user)


@receiver(post_save, sender=Review)
def update_product_rating(sender, instance, **kwargs):
    if instance.product:
        instance.product.save()


class Wishlist(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)

    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="wishlist")

    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Wishlist"

    def __str__(self):
        if self.product.title:
            return self.product.title
        else:
            return "Wishlist"


class Notification(models.Model):

    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)

    vendor = models.ForeignKey(Vendor, on_delete=models.SET_NULL, null=True, blank=True)

    order = models.ForeignKey(CartOrder, on_delete=models.SET_NULL, null=True, blank=True)

    order_item = models.ForeignKey(CartOrderItem, on_delete=models.SET_NULL, null=True, blank=True)

    seen = models.BooleanField(default=False)

    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Notification"
        ordering = ["-date"]

    def __str__(self):
        if self.order:
            return self.order.oid
        else:
            return "Notification"


class Address(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    full_name = models.CharField(max_length=200)
    mobile = models.CharField(max_length=50)
    email = models.CharField(max_length=100)
    country = models.ForeignKey(
        "addon.Tax", on_delete=models.SET_NULL, null=True, related_name="address_country", blank=True
    )
    state = models.CharField(max_length=100)
    town_city = models.CharField(max_length=100)
    address = models.CharField(max_length=100)
    zip = models.CharField(max_length=100)
    status = models.BooleanField(default=False)
    same_as_billing_address = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = "Address"

    def __str__(self):
        if self.user:
            return self.user.username
        else:
            return "Address"


class CancelledOrder(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    orderitem = models.ForeignKey("store.CartOrderItem", on_delete=models.SET_NULL, null=True)

    email = models.CharField(max_length=100)

    refunded = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = "Cancelled Order"

    def __str__(self):
        if self.user:
            return str(self.user.username)
        else:
            return "Cancelled Order"


class Coupon(models.Model):

    vendor = models.ForeignKey(Vendor, on_delete=models.SET_NULL, null=True, related_name="coupon_vendor")

    used_by = models.ManyToManyField(User, blank=True)

    code = models.CharField(max_length=1000)

    discount = models.IntegerField(default=1, validators=[MinValueValidator(0), MaxValueValidator(100)])

    date = models.DateTimeField(auto_now_add=True)
    active = models.BooleanField(default=True)

    cid = ShortUUIDField(length=10, max_length=25, alphabet="abcdefghijklmnopqrstuvxyz")

    def save(self, *args, **kwargs):
        new_discount = int(self.discount) / 100
        self.get_percent = new_discount
        super(Coupon, self).save(*args, **kwargs)

    def __str__(self):
        return self.code

    class Meta:
        ordering = ["-id"]
        unique_together = ("vendor", "code")


class CouponUsers(models.Model):

    coupon = models.ForeignKey(Coupon, on_delete=models.CASCADE)

    order = models.ForeignKey(CartOrder, on_delete=models.CASCADE)

    full_name = models.CharField(max_length=1000)
    email = models.CharField(max_length=1000)
    mobile = models.CharField(max_length=1000)

    def __str__(self):
        return str(self.coupon.code)

    class Meta:
        ordering = ["-id"]


class DeliveryCouriers(models.Model):
    name = models.CharField(max_length=1000, null=True, blank=True)
    tracking_website = models.URLField(null=True, blank=True)
    url_parameter = models.CharField(null=True, blank=True, max_length=100)

    class Meta:
        ordering = ["name"]
        verbose_name_plural = "Delivery Couriers"

    def __str__(self):
        return self.name
