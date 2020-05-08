from django.contrib import admin
from users.models import Profile, User
from django.utils.html import format_html


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    def image_tag(self, obj):
        return format_html('<img src="{}" />'.format(obj.image.url))

    image_tag.short_description = 'Image'
    list_display = ['image_tag', ]

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    pass