# Generated by Django 4.2 on 2025-02-27 11:14

import django.db.models.deletion
import django.utils.timezone
import shortuuid.django_fields
from django.db import migrations, models

import userauths.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("vendor", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="Brand",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=100)),
                (
                    "image",
                    models.ImageField(
                        blank=True, default="brand.jpg", null=True, upload_to=userauths.models.user_directory_path
                    ),
                ),
                ("active", models.BooleanField(default=True)),
            ],
            options={
                "verbose_name_plural": "Brands",
            },
        ),
        migrations.CreateModel(
            name="Category",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=100)),
                (
                    "image",
                    models.ImageField(
                        blank=True, default="category.jpg", null=True, upload_to=userauths.models.user_directory_path
                    ),
                ),
                ("active", models.BooleanField(default=True)),
                ("slug", models.SlugField(blank=True, null=True)),
            ],
            options={
                "verbose_name_plural": "Categories",
            },
        ),
        migrations.CreateModel(
            name="Tag",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=30)),
                ("active", models.BooleanField(default=True)),
                ("slug", models.SlugField(max_length=30, unique=True, verbose_name="Tag slug")),
                (
                    "category",
                    models.ForeignKey(
                        default="",
                        on_delete=django.db.models.deletion.PROTECT,
                        to="store.category",
                        verbose_name="Category",
                    ),
                ),
            ],
            options={
                "verbose_name_plural": "Tags",
                "ordering": ("title",),
            },
        ),
        migrations.CreateModel(
            name="Product",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=100)),
                (
                    "image",
                    models.FileField(
                        blank=True, default="product.jpg", null=True, upload_to=userauths.models.user_directory_path
                    ),
                ),
                ("description", models.TextField(blank=True, null=True)),
                ("tags", models.CharField(blank=True, max_length=1000, null=True)),
                ("brand", models.CharField(blank=True, max_length=100, null=True)),
                ("price", models.DecimalField(blank=True, decimal_places=2, default=0.0, max_digits=12, null=True)),
                ("old_price", models.DecimalField(blank=True, decimal_places=2, default=0.0, max_digits=12, null=True)),
                ("shipping_amount", models.DecimalField(decimal_places=2, default=0.0, max_digits=12)),
                ("stock_qty", models.PositiveIntegerField(default=0)),
                ("in_stock", models.BooleanField(default=True)),
                (
                    "status",
                    models.CharField(
                        blank=True,
                        choices=[
                            ("draft", "Draft"),
                            ("disabled", "Disabled"),
                            ("rejected", "Rejected"),
                            ("in_review", "In Review"),
                            ("published", "Published"),
                        ],
                        default="published",
                        max_length=50,
                        null=True,
                    ),
                ),
                (
                    "type",
                    models.CharField(
                        choices=[("regular", "Regular"), ("auction", "Auction"), ("offer", "Offer")],
                        default="regular",
                        max_length=50,
                    ),
                ),
                ("featured", models.BooleanField(default=False)),
                ("hot_deal", models.BooleanField(default=False)),
                ("special_offer", models.BooleanField(default=False)),
                ("digital", models.BooleanField(default=False)),
                ("views", models.PositiveIntegerField(blank=True, default=0, null=True)),
                ("orders", models.PositiveIntegerField(blank=True, default=0, null=True)),
                ("saved", models.PositiveIntegerField(blank=True, default=0, null=True)),
                ("rating", models.IntegerField(blank=True, default=0, null=True)),
                (
                    "sku",
                    shortuuid.django_fields.ShortUUIDField(
                        alphabet="1234567890", length=5, max_length=50, prefix="SKU", unique=True
                    ),
                ),
                (
                    "pid",
                    shortuuid.django_fields.ShortUUIDField(
                        alphabet="abcdefghijklmnopqrstuvxyz", length=10, max_length=20, prefix="", unique=True
                    ),
                ),
                ("slug", models.SlugField(blank=True, null=True)),
                ("date", models.DateTimeField(default=django.utils.timezone.now)),
                (
                    "category",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="category",
                        to="store.category",
                    ),
                ),
                (
                    "vendor",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="vendor",
                        to="vendor.vendor",
                    ),
                ),
            ],
            options={
                "verbose_name_plural": "Products",
                "ordering": ["-id"],
            },
        ),
    ]
