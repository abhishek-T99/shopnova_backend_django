# Generated by Django 4.2 on 2025-02-27 11:27

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("addon", "0001_initial"),
        ("store", "0002_cartorder_cartorderitem_coupon_deliverycouriers_and_more"),
    ]

    operations = [
        migrations.AddField(
            model_name="address",
            name="country",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.SET_NULL,
                related_name="address_country",
                to="addon.tax",
            ),
        ),
    ]
