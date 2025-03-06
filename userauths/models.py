from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models.signals import post_save
from django.utils.html import mark_safe
from shortuuid.django_fields import ShortUUIDField

GENDER = (
    ("female", "Female"),
    ("male", "Male"),
)


def user_directory_path(instance, filename):
    user = None

    if hasattr(instance, "user") and instance.user:
        user = instance.user
    elif hasattr(instance, "vendor") and hasattr(instance.vendor, "user") and instance.vendor.user:
        user = instance.vendor.user
    elif hasattr(instance, "product") and hasattr(instance.product.vendor, "user") and instance.product.vendor.user:
        user = instance.product.vendor.user

    if user:
        ext = filename.split(".")[-1]
        filename = "%s.%s" % (user.id, ext)
        return "user_{0}/{1}".format(user.id, filename)
    else:
        ext = filename.split(".")[-1]
        filename = "%s.%s" % ("file", ext)
        return "user_{0}/{1}".format("file", filename)


class User(AbstractUser):
    username = models.CharField(max_length=500, null=True, blank=True)
    email = models.EmailField(unique=True)
    full_name = models.CharField(max_length=500, null=True, blank=True)
    phone = models.CharField(max_length=500)
    otp = models.CharField(max_length=1000, null=True, blank=True)
    reset_token = models.CharField(max_length=1000, null=True, blank=True)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["username"]

    def __str__(self):
        return self.email

    def __unicode__(self):
        return self.username

    def save(self, *args, **kwargs):
        email_username, mobile = self.email.split("@")
        if self.full_name == "" or self.full_name is None:
            self.full_name = self.email
        if self.username == "" or self.username is None:
            self.username = email_username
        super(User, self).save(*args, **kwargs)

    def get_profile_picture(self):
        if hasattr(self, "profile") and self.profile.image:
            return self.profile.image.url
        return None


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
    image = models.ImageField(upload_to="accounts/users", default="default/default-user.jpg", null=True, blank=True)
    full_name = models.CharField(max_length=1000, null=True, blank=True)
    about = models.TextField(null=True, blank=True)

    gender = models.CharField(max_length=500, choices=GENDER, null=True, blank=True)
    country = models.CharField(max_length=1000, null=True, blank=True)
    city = models.CharField(max_length=500, null=True, blank=True)
    state = models.CharField(max_length=500, null=True, blank=True)
    address = models.CharField(max_length=1000, null=True, blank=True)
    newsletter = models.BooleanField(default=False)
    type = models.CharField(max_length=500, choices=GENDER, null=True, blank=True)
    date = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    pid = ShortUUIDField(unique=True, length=10, max_length=20, alphabet="abcdefghijklmnopqrstuvxyz")

    class Meta:
        ordering = ["-date"]

    def __str__(self):
        if self.full_name:
            return str(self.full_name)
        else:
            return str(self.user.full_name)

    def save(self, *args, **kwargs):
        if self.full_name == "" or self.full_name is None:
            self.full_name = self.user.full_name

        super(Profile, self).save(*args, **kwargs)

    def thumbnail(self):
        return mark_safe(
            '<img src="/media/%s" width="50" height="50" object-fit:"cover" \
                style="border-radius: 30px; object-fit: cover;" />'
            % (self.image)
        )


def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)


def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()


post_save.connect(create_user_profile, sender=User)
post_save.connect(save_user_profile, sender=User)
