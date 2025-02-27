from django.contrib import admin
from import_export.admin import ImportExportModelAdmin

from addon.models import ConfigSettings, Tax


class TaxAdmin(ImportExportModelAdmin):
    list_editable = ["rate", "active"]
    list_display = ["country", "rate", "active"]


admin.site.register(Tax, TaxAdmin)
admin.site.register(ConfigSettings)
