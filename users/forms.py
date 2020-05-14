from django import forms
from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit, Row, Column, Fieldset, ButtonHolder, Div
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm

from users.models import Profile, Message

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


class ProfileUpdateForm(forms.Form):
    ACCT_TYPE_CHOICES = (
        ('', 'Choose Account Type...'),
        ("Single Male", "Single Male"),
        ("Single Female", "Single Female"),
        ("Couple", "Couple"),
    )

    STATE_CHOICES = (
        ('', 'Choose Your State...'),
        ('AL', 'Alabama'),
        ('AK', 'Alaska'),
        ('AZ', 'Arizona'),
        ('AR', 'Arkansas'),
        ('CA', 'California'),
        ('CO', 'Colorado'),
        ('CT', 'Connecticut'),
        ('DE', 'Delaware'),
        ('FL', 'Florida'),
        ('GA', 'Georgia'),
        ('HI', 'Hawaii'),
        ('ID', 'Idaho'),
        ('IL', 'Illinois'),
        ('IN', 'Indiana'),
        ('IA', 'Iowa'),
        ('KS', 'Kansas'),
        ('KY', 'Kentucky'),
        ('LA', 'Louisiana'),
        ('ME', 'Maine'),
        ('MD', 'Maryland'),
        ('MA', 'Massachusetts'),
        ('MI', 'Michigan'),
        ('MN', 'Minnesota'),
        ('MS', 'Mississippi'),
        ('MO', 'Missouri'),
        ('MT', 'Montana'),
        ('NE', 'Nebraska'),
        ('NV', 'Nevada'),
        ('NH', 'New Hampshire'),
        ('NJ', 'New Jersey'),
        ('NM', 'New Mexico'),
        ('NY', 'New York'),
        ('NC', 'North Carolina'),
        ('ND', 'North Dakota'),
        ('OH', 'Ohio'),
        ('OK', 'Oklahoma'),
        ('OR', 'Oregon'),
        ('PA', 'Pennsylvania'),
        ('RI', 'Rhode Island'),
        ('SC', 'South Carolina'),
        ('SD', 'South Dakota'),
        ('TN', 'Tennessee'),
        ('TX', 'Texas'),
        ('UT', 'Utah'),
        ('VT', 'Vermont'),
        ('VA', 'Virginia'),
        ('WA', 'Washington'),
        ('WV', 'West Virginia'),
        ('WI', 'Wisconsin'),
        ('WY', 'Wyoming'),
    )

    image = forms.FileField(label='Public Profile Image', required=True)
    account_type = forms.ChoiceField(label='Account Type', choices=ACCT_TYPE_CHOICES)
    his_age = forms.CharField(label='His Age', required=False,
                              widget=forms.TextInput(attrs={'placeholder': 'Please Enter His Age'}))
    her_age = forms.CharField(label='Her Age', required=False,
                              widget=forms.TextInput(attrs={'placeholder': 'Please Enter Her Age'}))
    bio = forms.CharField(label='Your Bio', required=False,
                          widget=forms.Textarea(attrs={'placeholder': 'Tell us something about you!', 'rows': '5'}))
    city = forms.CharField(label='City', required=True,
                           widget=forms.TextInput(attrs={'placeholder': 'Enter your city'}))
    state = forms.ChoiceField(label='State', required=True,
                              choices=STATE_CHOICES)
    zip = forms.CharField(label='Zip', max_length = 5, min_length = 5, required=True,
                          widget=forms.TextInput(attrs={'placeholder': 'Enter your zip', 'id': 'zip_length'}))
    interests = forms.CharField(label='Your Interests', required=False,
                                widget=forms.Textarea(
                                    attrs={'placeholder': 'What are your interests? What are you looking for?',
                                           'rows': '2'}))
    kik = forms.CharField(label='Kik Username', required=False,
                          widget=forms.TextInput(attrs={'placeholder': 'Enter your Kik Username'}))

    def __init__(self, *args, **kwargs):
        super(ProfileUpdateForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            Row(
                Column('account_type', css_class='form-group col-6'),
                Column('image', css_class='form-group col-6')
            ),
            Row(
                Column('his_age', css_class='form-group col-6'),
                Column('her_age', css_class='form-group col-6')
            ),
            Row(
                Column('bio', css_class='form-group col-12')
            ),
            Row(
                Column('city', css_class='form-group col-4'),
                Column('state', css_class='form-group col-4'),
                Column('zip', css_class='form-group col-4')
            ),
            Row(
                Column('interests', css_class='form-group col-12')
            ),
            Row(
                Column('kik', css_class='form-group col-6')
            ),
            ButtonHolder(
                Submit('save', 'Save')
            ),
        )


class VerificationStep1Form(forms.Form):
    phone = forms.CharField(label='Phone Number',
                            widget=forms.TextInput(attrs={'placeholder': '555-555-555'}))


class VerificationStep2Form(forms.Form):
    code = forms.CharField(label='Received Code',
                           widget=forms.TextInput(attrs={'placeholder': '12345'}))


class SignInPhotoVerifyForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ['verification_image']
