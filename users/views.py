import time
from django.contrib import messages
from django.contrib.auth import login, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.core import serializers
from django.db.models import Q
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect

from blog.models import Post
from users.forms import *
from users.services import send_twilio_message
from .models import VerificationCode, Message, Conversation, Verification, Friendship


data_response = {}


# class

# debug
def debug(request):
    return redirect('')


def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            user_object = form.save()
            user_object.is_active = True
            user_object.save()
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password1')
            # user = authenticate(username=username, password=password)
            user = form.save()
            login(request, user, backend='django.contrib.auth.backends.ModelBackend')
            # messages.success(request, f'Your account has been created! You are now able to log in!')
            return redirect('register/profile')
    else:
        form = UserRegisterForm()
    return render(request, 'users/register.html', {'form': form})


def register_profile(request):
    t = request.user

    if request.method == 'POST':
        form = UserRegisterProfileForm(request.POST, request.FILES)
        if form.is_valid():
            profile = Profile.objects.get(user=request.user)
            profile.image = form.cleaned_data['image']
            profile.his_age = form.cleaned_data['his_age']
            profile.her_age = form.cleaned_data['her_age']
            profile.bio = form.cleaned_data['bio']
            profile.city = form.cleaned_data['city']
            profile.state = form.cleaned_data['state']
            profile.zip = form.cleaned_data['zip']
            profile.interests = form.cleaned_data['interests']
            profile.kik = form.cleaned_data['kik']
            profile.account_type = form.cleaned_data['account_type']
            profile.save()
            return redirect('phone_verification_step1')
    else:
        form = UserRegisterProfileForm(request.POST, request.FILES)

    context = {
        'form': form
    }
    return render(request, 'users/sign-up-profile.html', context)


@login_required()
def verification_step1(request):
    form = VerificationStep1Form(request.POST or None)
    if request.method == 'POST':
        if form.is_valid():
            user = request.user
            phone = form.cleaned_data.get('phone')
            code = VerificationCode.objects.create(user_id=user, phone=phone)
            send_twilio_message(phone, f'Your Code is : {code.code}')
            return redirect('phone_verification_step2')
    return render(request, 'users/sign-up-phone-verify.html', {'form': form})



def verification_step2(request):
    successful_url = redirect('profile-photo-verify')
    form = VerificationStep2Form(request.POST or None)
    if request.method == 'POST':
        if form.is_valid():
            user = request.user
            code = form.cleaned_data.get('code')
            verification = VerificationCode.objects.filter(user_id=user).latest()
            if verification.phone_verified:
                return successful_url
            if verification.valid_until > time.time():
                if code == verification.code:
                    verification.phone_verified = True
                    verification.save()
                    return successful_url
                else:
                    messages.error(request, "The code you entered is not correct!")
            else:
                messages.error(request, "This code has expired!")
    return render(request, 'users/sign-up-phone-verify_step2.html', {'form': form})



def sign_in_photo_verify(request):
    form = SignInPhotoVerifyForm(request.POST or None, request.FILES or None)
    if request.method == 'POST':
        if form.is_valid():
            verification = Verification.objects.get(user=request.user)
            verification.verification_image = form.files['verification_image']
            verification.save()
            return render(request, 'users/sign-in-photo-verify-confirmation.html')
    return render(request, 'users/sign-in-photo-verify.html', {'form': form})


# @login_required()
# def profile(request):
#     if request.method == 'POST':
#         u_form = UserUpdateForm(request.POST,
#                                 instance=request.user)
#         p_form = ProfileUpdateForm(request.POST,
#                                    request.FILES,
#                                    instance=request.user.profile)
#         if u_form.is_valid() and p_form.is_valid():
#             u_form.save()
#             p_form.save()
#             messages.success(request, f'Your account has been updated!')
#             return redirect('profile')
#     else:
#         u_form = UserUpdateForm(instance=request.user)
#         p_form = ProfileUpdateForm(instance=request.user.profile)
#
#     context = {
#         'u_form': u_form,
#         'p_form': p_form
#     }
#     return render(request, 'users/profile_old_delete.html', context)
#     # return redirect('home')

def friend_request(request):
    data_response['success'] = 'success'
    return JsonResponse(data_response)


def friend_request_notifications(request):
    return render(request, 'users/friend-request.html')


def get_friend_request_list(request):
    return HttpResponse([], content_type="text/json-command-filtered")


def accept_friend_request(request):
    data_response['success'] = 'success'
    return JsonResponse(data_response)


def reject_friend_request(request):
    data_response['success'] = 'success'
    return JsonResponse(data_response)


def block_friend_request(request):
    data_response['success'] = 'success'
    return JsonResponse(data_response)


def check_block(request):
    data_response['response'] = 'no'
    return JsonResponse(data_response)


def profile_detail(request, username):
    selected_id = User.objects.filter(username=username).first().id

    context = {
        'selectedUser': User.objects.filter(username=username).first(),
    }
    return render(request, 'users/profile-detail.html', context)


def notifications(request):
    return render(request, 'users/notification.html')


def profile_videos(request):
    return render(request, 'users/profile-video.html')


def profile_friend_list(request):
    return render(request, 'users/friend-list.html')


def profile_images(request):
    return render(request, 'users/profile-images.html')


# http://localhost:8000/users/profile/user_review/
def profile_friend_review(request, username):
    selectedId = User.objects.filter(username=username).first().id

    context = {
        'selectedUser': User.objects.filter(username=username).first(),
        'friends': []

    }
    return render(request, 'users/friend-review.html', context)


def profile_create_review(request):

    return render(request, 'users/friend-create-review.html')


def profile_edit(request):
    return render(request, 'users/profile-edit.html')

def photo_verify_success(request):
    return render(request, 'users/sign-in-photo-verify-confirmation.html')

def become_full_member(request):
    return render(request, 'users/pages-pricing-one.html')


# messages

#debug add conversation from url

def debug_add_convo(request, username):
    other_user = User.objects.get(username=username)
    C = Conversation()
    C.save()
    C.users.add(other_user, request.user)
    C.save()
    return JsonResponse({'fired': True})


def chat(request):
    user_id = request.user.id

    conversations_raw = list(Conversation.objects.filter(users__id=user_id))
    conversations = []

    for i in range(0, len(conversations_raw)):
        user2 = conversations_raw[i].users.exclude(id=user_id).first()
        last_message = None
        if conversations_raw[i].message_count > 0:
            last_message = Message.objects.filter(id=conversations_raw[i].last_message_id).first()

        convo_id = conversations_raw[i].id

        if user2 is not None:
            conversations.append({})
            conversations[i]["id"] = str(convo_id)
            conversations[i]["name"] = user2.first_name
            if last_message is not None:
                conversations[i]["lastMessage"] = last_message.content[:70] + (last_message.content[70:] and '...')
                conversations[i]["lastUpdate"] = last_message.timestamp

    context = {'conversations': conversations, 'myName': request.user.first_name, 'id': user_id}

    return render(request, 'users/chat.html', context)


# Different types of messages from import messages
# messages.debug
# messages.info
# messages.success
# messages.warning
# messages.error
