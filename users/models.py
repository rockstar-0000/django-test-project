from django.contrib.auth.models import AbstractUser
from django.core.files.storage import FileSystemStorage
from django.db import models
from PIL import Image
from django.utils import timezone
from django.apps import apps
from django_site.settings import UPLOAD_DIR
import time

# TODO Create a util file


def NOW_TIMESTAMP():
    return int(round(time.time()))


class BaseModel(models.Model):
    timestamp = models.IntegerField(default=NOW_TIMESTAMP())
    last_timestamp = models.IntegerField(default=NOW_TIMESTAMP())

    class Meta:
        abstract = True
        get_latest_by = "last_timestamp"

    def save(self, *args, **kwargs):
        self.last_update = NOW_TIMESTAMP()
        super().save(*args, **kwargs)  # Call the "real" save() method.


class User(AbstractUser):

    is_verified = models.BooleanField(default=False)

    def get_friendship(self, other_user_id):
        Friendship_Model: Friendship = apps.get_model('users', 'Friendship')
        other_user = User.objects.filter(pk=other_user_id).first()
        if other_user is None:
            return None

        # TODO fix this scenario: user1 blocks users2 we need to somehow save that maybe add status table???
        user_friendships = Friendship_Model.objects.filter(users=self, status=Friendship_Model.Status.FRIENDS)
        other_friendships = Friendship_Model.objects.filter(users=other_user, status=Friendship_Model.Status.FRIENDS)
        return user_friendships.intersection(other_friendships).first()

    def is_friend(self, other_user_id):
        if self.get_friendship(other_user_id) is None:
            return False
        else:
            return True

    def get_conversations(self):
        Conversation_Model: Conversation = apps.get_model('users', 'Conversation')
        return list(Conversation_Model.objects.filter(users=self))

    def get_profile(self):
        Profile_Model: Profile = apps.get_model('users', 'Profile')
        return Profile_Model.objects.filter(user=self).first()



# Each user is apart of two conversations one as the sender and one as the receiver
class Conversation(BaseModel):
    users = models.ManyToManyField(User)
    message_count = models.IntegerField(default=0)
    last_message = models.ForeignKey('Message', null=True, on_delete=models.CASCADE)


class Message(BaseModel):
    convo = models.ForeignKey(Conversation, on_delete=models.CASCADE)
    from_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="from_user")
    content = models.TextField(blank=False, null=True)
    has_read = models.BooleanField(default=False)


class Socket(BaseModel):
    # TODO add correct max_length of channel name
    channel_name = models.CharField(default="", max_length=128, unique=True)
    is_connected = models.BooleanField(default=False)
    user = models.OneToOneField(User, on_delete=models.CASCADE)


# Verification is in separate table because users can have multiple verification attempts
class Verification(BaseModel):
    class StatusType(models.TextChoices):
        NONE = ''
        APPROVED = 'approved'
        DECLINED = 'declined'
    status = models.CharField(max_length=10, default='', choices=StatusType.choices)
    verification_image = models.ImageField(
        default='default.jpg',
        null=True,
        blank=True,
        verbose_name='Verification Image',
        max_length=255,
        storage=FileSystemStorage(location=UPLOAD_DIR, base_url='/media/uploads/'))
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return f'{self.user.username} Profile'

    def save(self, *args, **kwargs):

        if self.status == self.StatusType.APPROVED:
            self.user.is_verified = True
            self.user.save()

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


class Address(BaseModel):
    city = models.CharField(max_length=30, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    zip = models.CharField(max_length=5, blank=True, null=True)
    country = models.CharField(max_length=40, blank=True, null=True)
    user = models.OneToOneField(User, on_delete=models.CASCADE)


class Profile(BaseModel):
    class AccountType(models.TextChoices):
        SINGLE_MALE = 'sm'
        SINGLE_FEMALE = 'sf'
        COUPLE = 'c'
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
    account_type = models.CharField(max_length=3, blank=True, choices=AccountType.choices, default='')
    user = models.OneToOneField(User, on_delete=models.CASCADE)

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
    users = models.ManyToManyField(User, through='Status')


class Status(BaseModel):
    friendship = models.ForeignKey(Friendship, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    class Relationship(models.TextChoices):
        FRIEND = 'friend'
        BLOCKED = 'blocked'
        IGNORE = 'ignore'
        NONE = ''

    relationship = models.CharField(max_length=8, choices=Relationship.choices, default=Relationship.NONE)


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


class ReviewContent(BaseModel):
    content = models.TextField()
    rating = models.IntegerField(null=True)


class Review(BaseModel):
    by_user = models.ForeignKey(User, on_delete=models.CASCADE)
    to_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='to_user')
    review_content = models.ForeignKey(ReviewContent, on_delete=models.CASCADE, related_name='review_content')
    reply_content = models.ForeignKey(ReviewContent, on_delete=models.CASCADE)


class Notification(BaseModel):
    content = models.CharField(max_length=256)
    has_read = models.BooleanField(default=False)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

# order

class Orders(BaseModel):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    payment_method = models.CharField(max_length=100)
    amount = models.CharField(max_length=100)
    token = models.CharField(max_length=100 ,default="NotTokenPaypal")
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return f'{self.first_name} {self.last_name}  : {self.email}'
