import time
from random import randint

from django.db import models
from django.contrib.auth.models import User
from PIL import Image


def get_upload_path(instance, filename):
    return '%s/%s' % (instance.user.username, filename)


class Profile(models.Model):
    single_male = "Single Male"
    single_female = "Single Female"
    couple = "Couple's Account"

    GENDER_CHOICES = (
        (single_male, "Single Male"),
        (single_female, "Single Female"),
        (couple, 'Couple'),
    )
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # make bio, current city, gender, etc and other stuff here
    image = models.ImageField(default='default.jpg', upload_to=get_upload_path)
    # image = models.ImageField(default='default.jpg', upload_to='profile_pics')
    gender = models.CharField(max_length=25, choices=GENDER_CHOICES, default=single_male)

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
    code = models.TextField(default=randint(10000, 99999))  # Generates the random code
    created_at = models.IntegerField(default=time.time())
    valid_until = models.IntegerField(default=time.time() + 1 * 60 * 60)  # Valid for 1 hour
    phone = models.TextField(blank=True)
    phone_verified = models.BooleanField(default=False)

    class Meta:
        db_table = 'verification_code'
        verbose_name = 'Verification Code'
        verbose_name_plural = 'Verification Codes'
        get_latest_by = "created_at"
