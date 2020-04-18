from django.contrib import admin
from django.contrib.auth import views as auth_views
# Django Tutorials 2 of 17
# need to import "include" if you are going to use the function
# in your path() function
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from users import views as users_views

urlpatterns = [
    path('admin/', admin.site.urls),
    # Django Tutorials 2 of 17
    # if you want to map to the blog app, you need to have a starting point
    # in the main urls.py file. Use the include() to point to the blog/urls.py
    # file. If you have more after blog/, then it will chop off blog/ and send
    # the remaining string to blog/urls.py.
    # you need a trailing slash
    path('blog/', include('blog.urls')),
    path('register/', users_views.register, name='register'),
    path('profile/', users_views.profile, name='profile'),
    path('profile/detail', users_views.profile_detail, name='profile-detail'),
    path('login/', auth_views.LoginView.as_view(template_name='users/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(template_name='users/logout.html'), name='logout'),
    path('password-reset/',
         auth_views.PasswordResetView.as_view(
             template_name='users/password_reset.html'),
         name='password_reset'
         ),
    path('password-reset/done/',
         auth_views.PasswordResetDoneView.as_view(template_name='users/password_done.html'),
         name='password_reset_done'),
    path('password-reset-confirm/<uidb64>/<token>',
         auth_views.PasswordResetConfirmView.as_view(
             template_name='users/password_reset_confirm.html'),
         name='password_reset_confirm'
         ),
    path('password-reset-complete/',
         auth_views.PasswordResetCompleteView.as_view(
             template_name='users/password_reset_complete.html'),
         name='password_reset_complete'
         ),
    # Django Tutorials 2 of 17
    # because of the empty string, it redirects to blog/urls.py
    path('', include('blog.urls')),
    path('users/', include('users.urls'))
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

