from django.contrib import admin

from userauths.models import Profile, User


class UserAdmin(admin.ModelAdmin):
    search_fields = ["full_name", "username", "email", "phone"]
    list_display = ["username", "email", "phone"]
    exclude = ["password"]


class ProfileAdmin(admin.ModelAdmin):
    search_fields = ["user"]
    list_display = ["full_name", "gender", "country"]
    list_filter = ["date"]


admin.site.register(User, UserAdmin)
admin.site.register(Profile, ProfileAdmin)
