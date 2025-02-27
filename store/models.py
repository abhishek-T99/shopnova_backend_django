from django.db import models


class Category(models.Model):
    title = models.CharField(max_length=100)
    image = models.FileField(upload_to="category", null=True, blank=True, default="vendor.jpg")
    active = models.BooleanField(default=True)
    slug = models.SlugField(null=True, blank=True)

    class Meta:
        verbose_name_plural = "Categories"

    def __str__(self):
        return self.title
