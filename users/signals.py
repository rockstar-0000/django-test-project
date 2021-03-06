import time
from random import randint

from django.db.models.signals import pre_save
from django.dispatch import receiver

from users.models import VerificationCode


@receiver(pre_save, sender=VerificationCode)
def set_times(sender, instance, **kwargs):
    instance.created_at = time.time()
    instance.valid_until = time.time() + 1 * 60 * 60
    instance.code = randint(10000, 99999)
