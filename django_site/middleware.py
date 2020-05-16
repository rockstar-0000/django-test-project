from django.contrib import messages
from django.contrib.auth import logout
from django.http import HttpResponseRedirect
from django.urls import reverse
from users.models import Verification


def _profile_is_approved(user):
    if user.is_anonymous is not True:
        if user.is_authenticated:
            return user.is_verified
    return False


class ProfileCheckMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        print(request.path)
        login_url = reverse("login")
        register_profile_url = reverse("register_profile")
        register = reverse("register")
        url_whitelist = [
                            reverse("register_profile"),
                            reverse("phone_verification_step1"),
                            reverse("phone_verification_step2"),
                            reverse("profile-photo-verify"),
                            reverse("sign_in_photo_verify_success"),
                            reverse("login"),
                            reverse("register"),

                         ]  # Include a list of authenticated views that don't require an approved profile

        if not _profile_is_approved(request.user) and request.path not in url_whitelist:
            if request.user.is_anonymous:
                return HttpResponseRedirect(login_url)
            else:
                messages.error(request, 'Your profile is not yet approved.')
                return HttpResponseRedirect(login_url)

        if request.path == reverse("register") and request.user.is_anonymous is not True:
            return HttpResponseRedirect(register_profile_url)

        if request.path == reverse("register_profile") and request.user.is_anonymous is True:
            return HttpResponseRedirect(register)

        response = self.get_response(request)

        return response
