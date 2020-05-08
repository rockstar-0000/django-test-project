from django import forms
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm
from .models import Profile, VerificationCode

User = get_user_model()


class UserRegisterForm(UserCreationForm):

    email = forms.EmailField()
    first_name = forms.CharField(max_length=30)
    last_name = forms.CharField(max_length=30)


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
        fields = ['image',
                  'his_age',
                  'her_age',
                  'bio',
                  'city',
                  'state',
                  'zip',
                  'interests',
                  'kik',
                  'gender']


class VerificationStep1Form(forms.Form):
    phone = forms.CharField(label='Phone Number',
                            widget=forms.TextInput(attrs={'placeholder': '555-555-555'}))


class VerificationStep2Form(forms.Form):
    code = forms.CharField(label='Received Code',
                            widget=forms.TextInput(attrs={'placeholder': '12345'}))

