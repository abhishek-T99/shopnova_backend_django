from django.contrib import admin

from userauths.models import Profile, User

admin.site.register(User)
admin.site.register(Profile)
