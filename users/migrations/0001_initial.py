# Generated by Django 3.0.3 on 2020-05-08 17:34

from django.conf import settings
import django.contrib.auth.models
import django.contrib.auth.validators
import django.core.files.storage
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0011_update_proxy_permissions'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('username', models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()], verbose_name='username')),
                ('first_name', models.CharField(blank=True, max_length=30, verbose_name='first name')),
                ('last_name', models.CharField(blank=True, max_length=150, verbose_name='last name')),
                ('email', models.EmailField(blank=True, max_length=254, verbose_name='email address')),
                ('is_staff', models.BooleanField(default=False, help_text='Designates whether the user can log into this admin site.', verbose_name='staff status')),
                ('is_active', models.BooleanField(default=True, help_text='Designates whether this user should be treated as active. Unselect this instead of deleting accounts.', verbose_name='active')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='date joined')),
                ('approved', models.BooleanField(default=False)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.Group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.Permission', verbose_name='user permissions')),
            ],
            options={
                'verbose_name': 'user',
                'verbose_name_plural': 'users',
                'abstract': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.CreateModel(
            name='Friend',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sender_id', models.IntegerField()),
                ('recipient_id', models.IntegerField()),
                ('sender_firstName', models.CharField(default='', max_length=35)),
                ('sender_lastName', models.CharField(default='', max_length=35)),
                ('sender_image', models.ImageField(default='default.jpg', upload_to='')),
                ('recipient_firstName', models.CharField(default='', max_length=35)),
                ('recipient_lastName', models.CharField(default='', max_length=35)),
                ('recipient_image', models.ImageField(default='default.jpg', upload_to='')),
                ('state', models.CharField(choices=[('New_Accept', 'New_Accept'), ('Wait', 'Wait'), ('Accept', 'Accept'), ('Block', 'Block')], default='Wait', max_length=35)),
            ],
        ),
        migrations.CreateModel(
            name='VerificationCode',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.TextField()),
                ('created_at', models.IntegerField()),
                ('valid_until', models.IntegerField()),
                ('phone', models.TextField(blank=True)),
                ('phone_verified', models.BooleanField(default=False)),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Verification Code',
                'verbose_name_plural': 'Verification Codes',
                'db_table': 'verification_code',
                'get_latest_by': 'created_at',
            },
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(max_length=255, storage=django.core.files.storage.FileSystemStorage(location='/mnt/1b0e4df8-44c6-432c-8b18-860457404e7e/home/s4/Sources/jgreen44/media/uploads'), upload_to='', verbose_name='Profile Image')),
                ('his_age', models.CharField(max_length=2, null=True)),
                ('her_age', models.CharField(max_length=2, null=True)),
                ('bio', models.TextField(blank=True, null=True)),
                ('city', models.CharField(max_length=30, null=True)),
                ('state', models.CharField(max_length=2, null=True)),
                ('zip', models.CharField(max_length=5, null=True)),
                ('interests', models.TextField(null=True)),
                ('kik', models.CharField(max_length=30, null=True)),
                ('gender', models.CharField(choices=[('M', 'Male'), ('F', 'Female'), ('C', 'Couple')], default='M', max_length=2)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
