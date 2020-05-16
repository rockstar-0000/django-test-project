from django.db import models
from django.utils import timezone
from django.urls import reverse
from django.contrib.postgres.fields import ArrayField

from users.models import User as USER_MODEL
from users.models import BaseModel


class Post(BaseModel):
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
    user = models.ForeignKey(USER_MODEL, on_delete=models.CASCADE)
    like_count = ArrayField(models.IntegerField(), null=True)
    dislike_count = ArrayField(models.IntegerField(), null=True)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('post-detail', kwargs={'pk': self.pk})

    def save(self, *args, **kwargs):
        super(Post, self).save(*args, **kwargs)


class Comment(BaseModel):
    content = models.TextField()
    image = models.CharField(max_length=250, blank=True)
    post = models.ForeignKey('blog.Post', on_delete=models.CASCADE, null=True, related_name='comments')
    author = models.ForeignKey(USER_MODEL, on_delete=models.CASCADE, null=True)
    upvote_count = models.IntegerField(default=0)
    downvote_count = models.IntegerField(default=0)
    def __str__(self):
        return self.content


class Vote(BaseModel):
    value = models.SmallIntegerField()
    comment = models.ForeignKey(Comment, on_delete=models.CASCADE, null=True)
    post = models.ForeignKey(Post, on_delete=models.CASCADE, null=True)
    user = models.ForeignKey(USER_MODEL, on_delete=models.CASCADE, null=True)
