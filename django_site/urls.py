from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from users import views as user_views


urlpatterns = [
    path('admin/', admin.site.urls),
    path('blog/', include('blog.urls')),
    path('register/', user_views.register, name='register'),
    path('register/profile/', user_views.register_profile, name='register_profile'),
    path('register/photo_verify/', user_views.sign_in_photo_verify, name='sign_in_photo_verify'),
    path('register/photo_verify_success/', user_views.photo_verify_success, name='sign_in_photo_verify_success'),
    # path('profile/', user_views.profile, name='profile'),
    path('login/', auth_views.LoginView.as_view(template_name='users/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login', template_name='users/logout.html'), name='logout'),
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
    path('', include('blog.urls')),
    path('users/', include('users.urls')),
    path('become_member/', user_views.become_full_member, name='become_full_member'),
    path('checkout/<str:packagename>/<str:price>', user_views.check_out, name='check_out'),
    path('payment_return/', user_views.payment_return, name='payment_return'),
    path('payment/confirm', user_views.payment_successful, name='payment_successfull'),

]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)