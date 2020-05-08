import time
from random import randint

from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from users.models import Profile, VerificationCode, User


@receiver(pre_save, sender=User)
def set_new_user_inactive(sender, instance, **kwargs):
    if instance._state.adding is True:
        print("Creating Inactive User")
        instance.is_active = False
    else:
        print("Updating User Record")


@receiver(post_save, sender=User)
def create_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)


@receiver(post_save, sender=User)
def save_profile(sender, instance, **kwargs):
    instance.profile.save()


@receiver(pre_save, sender=VerificationCode)
def set_times(sender, instance, **kwargs):
    instance.created_at = time.time()
    instance.valid_until = time.time() + 1 * 60 * 60
    instance.code = randint(10000, 99999)
