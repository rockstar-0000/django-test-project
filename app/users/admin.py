from django.contrib import admin
from django.utils.safestring import mark_safe

from users.models import Profile, User
from django.utils.html import format_html


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    readonly_fields = ["verification_image_tag"]


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    pass
