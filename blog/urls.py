
from django.urls import path
from .views import (
    PostListview,
    PostDetailView,
    PostCreateView,
    PostUpdateView,
    PostDeleteView,
    UserPostListview
)
# Django Tutorials 2/17
# the dot is the current directory of blog and you
# have to import the "views" which is views.py
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
    # Django Tutorials 2 of 17
    # if you type "about" after blog/ in the URL, then it will go to the
    # views.py function called "about". The name= is used for reverse URL
    # lookup
    path('about/', views.about, name='blog-about'),

]