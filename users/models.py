from enum import Enum

from PIL import Image
from django.contrib.auth.models import AbstractUser
from django.db import models


def get_upload_path(instance, filename):
    return '%s/%s' % (instance.user.username, filename)


class User(AbstractUser):
    approved = models.BooleanField(default=False)

    def is_approved(self):
        return self.approved
    pass


class ProfileGenderEnum(Enum):
    MALE = 'M'
    FEMALE = 'F'
    COUPLE = 'C'

    @staticmethod
    def choices():
        return [(member.value, name) for name, member in ProfileGenderEnum.__members__.items()]


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image = models.ImageField(default='default.jpg', upload_to=get_upload_path)
    his_age = models.CharField(max_length=2)
    her_age = models.CharField(max_length=2)
    bio = models.TextField()
    city = models.CharField(max_length=30)
    state = models.CharField(max_length=2)
    zip = models.CharField(max_length=5)
    interests = models.TextField()
    kik = models.CharField(max_length=30)
    gender = models.CharField(max_length=2, choices=ProfileGenderEnum.choices(), default=ProfileGenderEnum.MALE)

    def __str__(self):
        return f'{self.user.username} Profile'

    def save(self, *args, **kwargs):
        super(Profile, self).save(*args, **kwargs)

        img = Image.open(self.image.path)

        if img.height > 300 or img.width > 300:
            output_size = (300, 300)
            img.thumbnail(output_size)
            img.save(self.image.path)


class Friend(models.Model):
    wait = "Wait"
    accept = "Accept"
    block = "Block"
    new_accept = "New_Accept"

    STATE_CHOICES = {
        (accept, "Accept"),
        (wait, "Wait"),
        (block, "Block"),
        (new_accept, "New_Accept")
    }

    sender_id = models.IntegerField()
    recipient_id = models.IntegerField()
    sender_firstName = models.CharField(max_length=35, default='')
    sender_lastName = models.CharField(max_length=35, default='')
    sender_image = models.ImageField(default='default.jpg', upload_to=get_upload_path)
    recipient_firstName = models.CharField(max_length=35, default='')
    recipient_lastName = models.CharField(max_length=35, default='')
    recipient_image = models.ImageField(default='default.jpg', upload_to=get_upload_path)
    state = models.CharField(max_length=35, choices=STATE_CHOICES, default=wait)

    # user = models.OneToOneField(User, on_delete=models.CASCADE)

    # def __str__(self):
    #     return '%s %s' % (self.sender_id, self.recipient_id)

    def save(self, *args, **kwargs):
        super(Friend, self).save(*args, **kwargs)


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
