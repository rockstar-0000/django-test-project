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

