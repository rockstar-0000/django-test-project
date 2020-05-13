from django.contrib.auth import REDIRECT_FIELD_NAME
from django.contrib.auth.decorators import user_passes_test


def _profile_is_approved(user):
    if user.is_authenticated and getattr(user, "profile", False):
        return user.profile.approved
    return user.is_anonymous


def approval_required(function=None, redirect_field_name=REDIRECT_FIELD_NAME, login_url=None):
    """
    Decorator for views that checks that the user's profile is approved redirecting
    to the log-in page if necessary.

    Usage:
    from django_site.decorators import approval_required

    @approval_required
    @login_required
    def some_view
    """
    actual_decorator = user_passes_test(
        lambda u: _profile_is_approved(u),
        login_url=login_url,
        redirect_field_name=redirect_field_name
    )
    if function:
        return actual_decorator(function)
    return actual_decorator
