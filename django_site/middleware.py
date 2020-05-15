from django.contrib import messages
from django.contrib.auth import logout
from django.http import HttpResponseRedirect
from django.urls import reverse
from users.models import Verification


def _profile_is_approved(user):
    if user.is_anonymous is not True:
        verification = Verification.objects.filter(user=user).first()
        if user.is_authenticated and verification is not None:
            return verification.is_approved
    return False


class ProfileCheckMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        print(request.path)
        login_url = reverse("login")
        url_whitelist = [
                            reverse("sign_up_post"),
                            reverse("phone_verification_step1"),
                            reverse("phone_verification_step2"),
                            reverse("profile-photo-verify"),
                            reverse("sign_in_photo_verify_success"),
                            reverse("login"),
                            reverse("register")

                         ]  # Include a list of authenticated views that don't require an approved profile

        if not _profile_is_approved(request.user) and request.path not in url_whitelist:
            logout(request)
            messages.error(request, 'Your profile is not yet approved.')
            return HttpResponseRedirect(login_url)

        response = self.get_response(request)

        return response
