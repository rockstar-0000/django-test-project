from django.contrib.auth.models import AbstractUser
from django.core.files.storage import FileSystemStorage
from django.db import models
from PIL import Image
from django.utils import timezone

from django_site.settings import UPLOAD_DIR


class User(AbstractUser):

    def save(self, *args, **kwargs):
        super(User, self).save()
        Profile.objects.get_or_create(user=self)


# Each user is apart of two conversations one as the sender and one as the receiver
class Conversation(models.Model):
    users = models.ManyToManyField(User)
    timestamp = models.DateTimeField(auto_now_add=True,  null=True)
    message_count = models.IntegerField(default=0)
    last_message = models.ForeignKey('Message', null=True, on_delete=models.CASCADE)


class Message(models.Model):
    convo = models.ForeignKey(Conversation, on_delete=models.CASCADE)
    from_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="from_user")
    content = models.TextField(blank=False, null=True)
    has_read = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True,  null=True)


class Socket(models.Model):
    # TODO add correct max_length of channel name
    channel_name = models.CharField(default="", max_length=128, unique=True)
    last_timestamp = models.DateTimeField(auto_now_add=True,  null=True)
    is_connected = models.BooleanField(default=False)
    user = models.OneToOneField(User, on_delete=models.CASCADE)


class Verification(models.Model):
    is_approved = models.BooleanField(default=False)
    verification_image = models.ImageField(
        default='default.jpg',
        null=True,
        blank=True,
        verbose_name='Verification Image',
        max_length=255,
        storage=FileSystemStorage(location=UPLOAD_DIR, base_url='/media/uploads/'))
    user = models.OneToOneField(User, on_delete=models.CASCADE)

    def save(self, *args, **kwargs):
        super(Verification, self).save(*args, **kwargs)
        # open the image of the current instance
        verification_image = Image.open(self.verification_image.path)
        if verification_image.height > 500 or\
                verification_image.width > 500:
            output_size = (500, 500)
            verification_image.thumbnail(output_size)
            verification_image.save(self.verification_image.path)

    def verification_image_tag(self):
        from django.utils.html import escape
        from django.utils.html import mark_safe
        return mark_safe('<img src="%s" />' % escape(self.verification_image.url))
    verification_image_tag.short_description = 'Verification Image'
    verification_image_tag.allow_tags = True


class Address(models.Model):
    city = models.CharField(max_length=30, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    zip = models.CharField(max_length=5, blank=True, null=True)


class Profile(models.Model):
    class AccountType(models.TextChoices):
        MALE = 'Single Male'
        FEMALE = 'Single Female'
        COUPLE = 'Couple'
    image = models.ImageField(
        default='default.jpg',
        verbose_name='Profile Image',
        blank=True,
        max_length=255,
        storage=FileSystemStorage(location=UPLOAD_DIR, base_url='/media/uploads/'))
    first_name = models.CharField(max_length=64, blank=True, null=True)
    last_name = models.CharField(max_length=64, blank=True, null=True)
    his_age = models.CharField(max_length=2, blank=True, null=True)
    her_age = models.CharField(max_length=2, blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    interests = models.TextField(blank=True, null=True)
    kik = models.CharField(max_length=30, blank=True, null=True)
    account_type = models.CharField(max_length=13, blank=True, choices=AccountType.choices, default='')
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    address = models.OneToOneField(Address, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return f'{self.user.username} Profile'

    def save(self, *args, **kwargs):
        super(Profile, self).save(*args, **kwargs)
        # open the image of the current instance
        profile_image = Image.open(self.image.path)

        if profile_image.height > 500 or\
                profile_image.width > 500:
            output_size = (500, 500)
            profile_image.thumbnail(output_size)
            profile_image.save(self.image.path)


class Friendship(models.Model):
    class Status(models.TextChoices):
        BLOCKED = 'block'
        FRIENDS = 'friends'
        IGNORE = 'ignore'
    timestamp = models.DateTimeField(auto_now_add=True,  null=True)
    status = models.CharField(choices=Status.choices, max_length=8, default='')
    users = models.ManyToManyField(User)


class VerificationCode(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    code = models.TextField()
    created_at = models.IntegerField()
    valid_until = models.IntegerField()
    phone = models.TextField(blank=True)
    phone_verified = models.BooleanField(default=False)

    class Meta:
        db_table = 'verification_code'
        verbose_name = 'Verification Code'
        verbose_name_plural = 'Verification Codes'
        get_latest_by = "created_at"


class ReviewContent(models.Model):
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    rating = models.IntegerField(null=True)


class Review(models.Model):
    timestamp = models.DateTimeField(auto_now_add=True)
    by_user = models.ForeignKey(User, on_delete=models.CASCADE)
    to_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='to_user')
    review_content = models.ForeignKey(ReviewContent, on_delete=models.CASCADE, related_name='review_content')
    reply_content = models.ForeignKey(ReviewContent, on_delete=models.CASCADE)


class Notification(models.Model):
    content = models.CharField(max_length=256)
    timestamp = models.DateTimeField(auto_now_add=True)
    has_read = models.BooleanField(default=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
