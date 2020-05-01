
from django.urls import path
from .views import (
    PostListview,
    PostDetailView,
    PostCreateView,
    PostUpdateView,
    PostDeleteView,
    UserPostListview
)
from . import views

urlpatterns = [
    # path('', PostListview.as_view(), name='blog-home'),
    path('', views.redirectPage, name='home'),
    path('home/', PostListview.as_view(), name='blog-home'),
    path('user/<str:username>/', UserPostListview.as_view(), name='user-posts'),
    path('post/<int:pk>/', PostDetailView.as_view(), name='post-detail'),
    path('post/new/', PostCreateView.as_view(), name='post-create'),
    path('post/<int:pk>/update/', PostUpdateView.as_view(), name='post-update'),
    path('post/<int:pk>/delete/', PostDeleteView.as_view(), name='post-delete'),
    # path('', views.home, name='blog-home'),
    path('about/', views.about, name='blog-about'),

    path('add_new_post/', views.add_new_post, name='add_new_post'),
    path('post/add_new_comment/', views.add_new_comment, name='add_new_comment'),
    path('post/get_comments/', views.get_comments, name='get_comments'),
    path('post/upvote/', views.upvote, name='upvote'),
    path('post/upvoteComment/', views.upvoteComment, name='upvoteComment'),
    path('post/downvote/', views.downvote, name='downvote'),
    path('post/downvotecomment/', views.downvotecomment, name='downvotecomment'),
    path('post/addUsername/', views.addUsername, name='addUsername'),
]