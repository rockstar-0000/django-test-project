from django.urls import path


from . import views

urlpatterns = [
    path('friend_request/', views.friend_request, name='friend_request'),
    path('friend_request/notifications/', views.friend_request_notifications, name='friend_request_notifications'),
    path('friend_request_list/', views.get_friend_request_list, name='friend_request_list'),
    path('accept_friend_request/', views.accept_friend_request, name='accept_friend_request'),
    path('reject_friend_request/', views.reject_friend_request, name='reject_friend_request'),
    path('block_friend_request/', views.block_friend_request, name='block_friend_request'),

    # new paths for new site
    path('profile/videos/', views.profile_videos, name='profile-videos'),
    path('profile/friend_list/', views.profile_friend_list, name='profile-friend-list'),
    path('profile/user_review/', views.profile_friend_review, name='profile-friend-review'),
    path('profile/friend_create_review/', views.profile_create_review, name='profile-friend-create-review'),
    path('profile/user_images/', views.profile_images, name='profile-user-images'),
    path('profile/user_edit/', views.profile_edit, name='profile-user-edit'),
    path('profile/<str:username>/', views.profile_detail, name='profile-detail'),
    path('check_block/', views.check_block, name='check_block'),
    path('notifications/', views.notifications, name='notifications'),
    path('profile/phone_verification1', views.verification_step1, name='phone_verification_step1'),
    path('profile/phone_verification2', views.verification_step2, name='phone_verification_step2'),
    path('profile/photo_verify', views.sign_in_photo_verify, name='profile-photo-verify'),
    path('messages/', views.user_messages, name='user_messages'),
]