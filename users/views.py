from django.shortcuts import render, redirect
from django.contrib import messages
from django.core import serializers
from django.http import JsonResponse, HttpResponse
from django.db.models import Q
from django.contrib.auth import login, authenticate
from .forms import UserRegisterForm, UserUpdateForm, ProfileUpdateForm
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from pprint import pprint
from .models import Friend

data_response = {}


def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=password)
            # login(request, user)
            messages.success(request, f'Your account has been created! You are now able to log in!')
            return redirect('login')
    else:
        form = UserRegisterForm()
    return render(request, 'users/register.html', {'form': form})


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
        print(len(already_list1))
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
            friend = Friend(sender_id=sender_id, recipient_id=recipient_id, sender_firstName=sender_firstName, sender_lastName=sender_lastName, sender_image=sender_image,
                            recipient_firstName=recipient_firstName, recipient_lastName=recipient_lastName, recipient_image=recipient_image)
            Friend.save(friend)
            return JsonResponse(data_response)


def get_friend_request_list(request):
    if request.method == 'POST':
        userId = request.POST.get('userId')

        friend_request_object = Friend.objects.filter(Q(recipient_id=userId, state="Wait") | Q(recipient_id=userId, state="Accept") | Q(sender_id=userId, state='Accept'))
        # print(friend_request_list)

        friend_request_list = serializers.serialize('json', friend_request_object)

        return HttpResponse(friend_request_list, content_type="text/json-command-filtered")


def accept_friend_request(request):
    if request.method == 'POST':
        id = request.POST.get('id')

        modify = Friend.objects.get(pk=id)
        modify.state = "Accept"
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


@login_required()
def profile_detail(request):
    return render(request, 'users/profile-detail.html')



# Different types of messages from import messages
# messages.debug
# messages.info
# messages.success
# messages.warning
# messages.error
