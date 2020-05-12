from django.contrib import messages
from django.contrib.auth import logout
from django.http import HttpResponseRedirect
from django.urls import reverse


def _profile_is_approved(user):
    if user.is_authenticated and getattr(user, "profile", False):
        return user.profile.approved
    return user.is_anonymous


class ProfileCheckMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        print(request.path)
        login_url = reverse("login")
        url_whitelist = [reverse("sign_up_post")]  # Include a list of authenticated views that don't require an approved profile

        if not _profile_is_approved(request.user) and request.path not in url_whitelist:
            logout(request)
            messages.error(request, 'Your profile is not yet approved.')
            return HttpResponseRedirect(login_url)

        response = self.get_response(request)

        return response