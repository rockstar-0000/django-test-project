from django.urls import path


from . import views

urlpatterns = [
    path('friend_request/', views.friend_request, name='friend_request'),
    path('friend_request_list/', views.get_friend_request_list, name='friend_request_list'),
    path('accept_friend_request/', views.accept_friend_request, name='accept_friend_request'),
    path('reject_friend_request/', views.reject_friend_request, name='reject_friend_request'),
    path('block_friend_request/', views.block_friend_request, name='block_friend_request'),

    # new paths for new site

    path('profile/detail_2/', views.profile_detail_2, name='profile-detail2'),
    path('profile/<str:username>/', views.profile_detail, name='profile-detail'),
    path('check_block/', views.check_block, name='check_block')
]