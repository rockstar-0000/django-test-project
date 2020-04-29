from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from django.urls import reverse
from django.contrib.postgres.fields import ArrayField

class Post(models.Model):
    public = "public"
    private = "private"

    STATE_CHOICES = {
        (public, "public"),
        (private, "private")
    }

    title = models.CharField(max_length=250)
    content = models.TextField()
    images = ArrayField(models.CharField(max_length=250, blank=True), default=list, null=True)
    state = models.CharField(max_length=35, choices=STATE_CHOICES, default=public)
    # images = models.TextField()
    date_posted = models.DateTimeField(default=timezone.now)
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    like = ArrayField(models.IntegerField(), null=True)
    dislike = ArrayField(models.IntegerField(), null=True)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('post-detail', kwargs={'pk': self.pk})

    def save(self, *args, **kwargs):
        super(Post, self).save(*args, **kwargs)


class Comment(models.Model):
    content = models.TextField()
    image = models.CharField(max_length=250, blank=True)
    post = models.ForeignKey('blog.Post', on_delete=models.CASCADE, null=True, related_name='comments')
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.content
