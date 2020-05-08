from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from .models import Profile


class UserRegisterForm(UserCreationForm):
    single_male = "Single Male"
    single_female = "Single Female"
    couple = "Couple's Account"

    GENDER_CHOICES = (
        (single_male, "Single Male"),
        (single_female, "Single Female"),
        (couple, 'Couple'),
    )
    email = forms.EmailField()
    first_name = forms.CharField(max_length=30)
    last_name = forms.CharField(max_length=30)
    bio = forms.TextInput
    gender = forms.CharField(max_length=6, choices=GENDER_CHOICES, default=single_male)

    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name', 'password1', 'password2']

class UserUpdateForm(forms.ModelForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['username', 'email']

class ProfileUpdateForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ['image', 'gender']