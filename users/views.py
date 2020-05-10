import time
from datetime import datetime
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
from .models import Friend, VerificationCode, Message, Conversation

data_response = {}


# class

def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            user_object = form.save()
            user_object.is_active = True
            user_object.save()
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=password)
            login(request, user)
            # messages.success(request, f'Your account has been created! You are now able to log in!')
            return redirect('phone_verification_step1')
    else:
        form = UserRegisterForm()
    return render(request, 'users/register.html', {'form': form})


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


@login_required()
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
                    messages.error(request, "Is not correct")
            else:
                messages.error(request, "Expired")
    return render(request, 'users/sign-up-phone-verify_step2.html', {'form': form})


def sign_up_post(request):
    if request.method == 'POST':
        u_form = UserUpdateForm(request.POST, instance=request.user)
        p_form = ProfileUpdateForm(request.POST, request.FILES, instance=request.user)
        if p_form.is_valid():
            p_form.save()
            return redirect('sign_in_photo_verify')
    else:
        u_form = UserUpdateForm(instance=request.user)
        p_form = ProfileUpdateForm(instance=request.user.profile)

    context = {
        'u_form': u_form,
        'p_form': p_form
    }
    return render(request, 'users/sign-up-post.html', context)


@login_required()
def sign_in_photo_verify(request):
    form = SignInPhotoVerifyForm(request.POST or None, request.FILES or None)
    if request.method == 'POST':
        if form.is_valid():
            profile = Profile.objects.get(user=request.user)
            profile.verification_image = form.files['verification_image']
            profile.save()
            return render(request, 'users/sign-in-photo-verify-confirmation.html')
    return render(request, 'users/sign-in-photo-verify.html', {'form': form})


@login_required()
def profile(request):
    if request.method == 'POST':
        u_form = UserUpdateForm(request.POST,
                                instance=request.user)
        p_form = ProfileUpdateForm(request.POST,
                                   request.FILES,
                                   instance=request.user.profile)
        if u_form.is_valid() and p_form.is_valid():
            u_form.save()
            p_form.save()
            messages.success(request, f'Your account has been updated!')
            return redirect('profile')
    else:
        u_form = UserUpdateForm(instance=request.user)
        p_form = ProfileUpdateForm(instance=request.user.profile)

    context = {
        'u_form': u_form,
        'p_form': p_form
    }
    return render(request, 'users/profile.html', context)
    # return redirect('home')


def friend_request(request):
    if request.method == 'POST':
        recipient_id = request.POST.get("recipient_id")
        recipient_firstName = request.POST.get("recipient_firstName")
        recipient_lastName = request.POST.get("recipient_lastName")
        recipient_image = request.POST.get("recipient_image")
        sender_id = request.POST.get("sender_id")
        sender_firstName = request.POST.get("sender_firstName")
        sender_lastName = request.POST.get("sender_lastName")
        sender_image = request.POST.get("sender_image")

        already_list1 = Friend.objects.filter(recipient_id=recipient_id, sender_id=sender_id)
        already_list2 = Friend.objects.filter(recipient_id=sender_id, sender_id=recipient_id)

        if len(already_list1) != 0:
            check_block = Friend.objects.filter(recipient_id=recipient_id, sender_id=sender_id, state='Block')
            if len(check_block) != 0:
                data_response['success'] = 'block'
            else:
                data_response['success'] = 'already_sent'
            return JsonResponse(data_response)
        elif len(already_list2) != 0:
            data_response['success'] = 'already_received'
            return JsonResponse(data_response)
        else:
            data_response['success'] = 'success'
            friend = Friend(sender_id=sender_id, recipient_id=recipient_id, sender_firstName=sender_firstName,
                            sender_lastName=sender_lastName, sender_image=sender_image,
                            recipient_firstName=recipient_firstName, recipient_lastName=recipient_lastName,
                            recipient_image=recipient_image)
            Friend.save(friend)
            return JsonResponse(data_response)


def friend_request_notifications(request):
    return render(request, 'users/friend-request.html')


def get_friend_request_list(request):
    if request.method == 'POST':
        userId = request.POST.get('userId')

        friend_request_object = Friend.objects.filter(
            Q(recipient_id=userId, state="Wait") | Q(recipient_id=userId, state="Accept") | Q(recipient_id=userId,
                                                                                              state="New_Accept") | Q(
                sender_id=userId,
                state='Accept') | Q(sender_id=userId, state="New_Accept"))

        friend_request_list = serializers.serialize('json', friend_request_object)

        Friend.objects.filter(sender_id=userId, state="New_Accept").update(state="Accept")

        return HttpResponse(friend_request_list, content_type="text/json-command-filtered")


def accept_friend_request(request):
    if request.method == 'POST':
        id = request.POST.get('id')

        modify = Friend.objects.get(pk=id)
        modify.state = "New_Accept"
        modify.save()

        data_response['success'] = 'success'
        return JsonResponse(data_response)


def reject_friend_request(request):
    if request.method == 'POST':
        id = request.POST.get('id')

        reject = Friend.objects.get(pk=id)
        reject.delete()

        data_response['success'] = 'success'
        return JsonResponse(data_response)


def block_friend_request(request):
    if request.method == 'POST':
        id = request.POST.get('id')

        block = Friend.objects.get(pk=id)
        block.state = "Block"
        block.save()

        data_response['success'] = 'success'
        return JsonResponse(data_response)


def check_block(request):
    if request.method == 'POST':
        recipientId = request.POST.get('recipientId')
        senderId = request.POST.get('senderId')
        already_block = Friend.objects.filter(
            Q(sender_id=request.user.id, recipient_id=recipientId, state="Block") | Q(sender_id=recipientId,
                                                                                      recipient_id=request.user.id,
                                                                                      state="Block"))
        if len(already_block) != 0:
            data_response['response'] = 'yes'
            return JsonResponse(data_response)
        else:
            data_response['response'] = 'no'
            return JsonResponse(data_response)


def profile_detail(request, username):
    selectedId = User.objects.filter(username=username).first().id
    userId = request.user.id
    already = ""
    friend = {}

    already_block = Friend.objects.filter(
        Q(state="Block", sender_id=selectedId, recipient_id=userId) | Q(state="Block", sender_id=userId,
                                                                        recipient_id=selectedId)).first()
    if already_block is not None:
        context = {'block': 'true'}
        return redirect('/home', context)

    already_sent = Friend.objects.filter(sender_id=userId, recipient_id=selectedId, state="Wait").first()
    already_received = Friend.objects.filter(sender_id=selectedId, recipient_id=userId, state="Wait").first()
    already_friend = Friend.objects.filter(
        Q(sender_id=userId, recipient_id=selectedId, state="Accept") | Q(sender_id=selectedId,
                                                                         recipient_id=userId,
                                                                         state="Accept") | Q(
            sender_id=userId, recipient_id=selectedId, state="New_Accept") | Q(sender_id=selectedId,
                                                                               recipient_id=userId,
                                                                               state="New_Accept")).first()

    if already_sent is not None:
        already = "sent"
    elif already_received is not None:
        already = "received"
        friend = already_received
    elif already_friend is not None:
        already = "friend"
        friend = already_friend

    context = {
        'selectedUser': User.objects.filter(username=username).first(),
        'friend': friend,
        'posts': Post.objects.filter(author_id=selectedId).order_by('-date_posted'),
        'already': already
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


def profile_friend_review(request):
    return render(request, 'users/friend-review.html')


def profile_create_review(request):
    return render(request, 'users/friend-create-review.html')


def profile_edit(request):
    return render(request, 'users/profile-edit.html')

def photo_verify_success(request):
    return render(request, 'users/sign-in-photo-verify-confirmation.html')

def become_full_member(request):
    return render(request, 'users/pages-pricing-one.html')


# messages

def create_message(request, conversation_id):
    if request.method == 'POST':
        message_text = request.POST.get('messageText')
        cur_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        msg = Message(conversation_id=int(conversation_id), from_user_id=request.user.id, message_text=message_text,
                      has_read=False)
        msg.save()

        C = Conversation.objects.get(pk=int(conversation_id))
        C.last_update = cur_time
        C.last_message_id = msg.id
        C.save()
        return conversation_messages(request, conversation_id)


def conversation_messages(request, conversation_id):
    messages = list(Message.objects.filter(conversation_id=conversation_id))
    sorted_messages = sorted(messages, key=lambda x: x.timestamp, reverse=True)

    context = {'messages': sorted_messages, 'userId': request.user.id, 'conversationId': conversation_id}
    return render(request, 'users/user-conversation-messages.html', context)

def user_messages(request):
    user_id = request.user.id

    # If Last_message_id is -1 then conversation has not started
    conversations_raw = list(Conversation.objects.filter(users__id=user_id, last_message_id__gt=0))
    conversations = []

    for i in range(0, len(conversations_raw)):
        user = conversations_raw[i].users.exclude(id=user_id).first()
        last_message = Message.objects.filter(id=conversations_raw[i].last_message_id).first().message_text
        last_update = conversations_raw[i].last_update
        convo_id = conversations_raw[i].id
        if user is not None and last_message is not None and last_update != -1:
            conversations.append({})
            conversations[i]["id"] = str(convo_id)
            conversations[i]["name"] = user.first_name
            conversations[i]["lastMessage"] = last_message[:70] + (last_message[70:] and '...')
            conversations[i]["lastUpdate"] = last_update

    context = {'conversations': conversations}

    return render(request, 'users/user-messages.html', context)



# Different types of messages from import messages
# messages.debug
# messages.info
# messages.success
# messages.warning
# messages.error
