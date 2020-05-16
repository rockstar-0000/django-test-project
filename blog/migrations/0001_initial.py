# Generated by Django 3.0.3 on 2020-05-16 18:00

import django.contrib.postgres.fields
from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('image', models.CharField(blank=True, max_length=250)),
                ('vote', django.contrib.postgres.fields.ArrayField(base_field=models.IntegerField(), null=True, size=None)),
                ('devote', django.contrib.postgres.fields.ArrayField(base_field=models.IntegerField(), null=True, size=None)),
            ],
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=250)),
                ('content', models.TextField()),
                ('images', django.contrib.postgres.fields.ArrayField(base_field=models.CharField(blank=True, max_length=250), default=list, null=True, size=None)),
                ('state', models.CharField(choices=[('private', 'private'), ('public', 'public')], default='public', max_length=35)),
                ('date_posted', models.DateTimeField(default=django.utils.timezone.now)),
                ('like', django.contrib.postgres.fields.ArrayField(base_field=models.IntegerField(), null=True, size=None)),
                ('dislike', django.contrib.postgres.fields.ArrayField(base_field=models.IntegerField(), null=True, size=None)),
            ],
        ),
    ]
