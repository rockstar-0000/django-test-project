from django.contrib import admin
from django.utils.safestring import mark_safe

from users.models import Profile, User, UserReview, UserReviewReply, Verification
from django.utils.html import format_html


@admin.register(Verification)
class ProfileAdmin(admin.ModelAdmin):
    readonly_fields = ["verification_image_tag"]


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    pass

admin.site.register(UserReview)
admin.site.register(UserReviewReply)