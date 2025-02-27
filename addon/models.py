from django.db import models

SERVICE_FEE_CHARGE_TYPE = (
    ("percentage", "Percentage"),
    ("flat_rate", "Flat Rate"),
)

AFFILIATE_COMMISSION_TYPE = (
    ("percentage", "Percentage"),
    ("flat_rate", "Flat Rate"),
)


class ConfigSettings(models.Model):
    view_more = models.CharField(default="View All", max_length=10)
    currency_sign = models.CharField(default="$", max_length=10)
    currency_abbreviation = models.CharField(default="USD", max_length=10)
    service_fee_percentage = models.IntegerField(
        default=5, help_text="NOTE: Numbers added here are in percentage (%)ve.g 4%"
    )
    service_fee_flat_rate = models.DecimalField(
        default=0.7,
        max_digits=12,
        decimal_places=2,
        help_text="NOTE: Add the amount you want to charge as service fee e.g $2.30",
    )
    service_fee_charge_type = models.CharField(default="percentage", max_length=30, choices=SERVICE_FEE_CHARGE_TYPE)
    enforce_2fa = models.BooleanField(default=True)
    activate_affiliate_system = models.BooleanField(default=True)
    send_email_notifications = models.BooleanField(default=False)

    class Meta:
        verbose_name = "Settings"
        verbose_name_plural = "Settings"


class Tax(models.Model):
    country = models.CharField(max_length=500)
    rate = models.IntegerField(default=5, help_text="Numbers added here are in percentage (5 = 5%)")
    active = models.BooleanField(default=True)
    date = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Tax"

    def __str__(self):
        return f"{self.country}"
