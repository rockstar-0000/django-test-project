from django.shortcuts import render, get_object_or_404
from django.contrib.auth import views as auth_views
from django.contrib.auth.views import LoginView as DefaultLoginView
from django.conf import settings
from django.http import JsonResponse, HttpResponse
from django.core.files.storage import FileSystemStorage
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib.auth.models import User
from django.contrib.auth.models import AnonymousUser
from django.shortcuts import redirect
from django.apps import apps
from django.views.generic import (
    ListView,
    DetailView,
    CreateView,
    UpdateView,
    DeleteView,
)
from .models import Post
from users.models import Profile


# from ..users import views as user_views

data_response = {}

def home(request):
    context = {
        'posts': Post.objects.all()
    }
    return render(request, 'blog/home.html', context)


class PostListview(ListView):
    model = Post
    template_name = 'blog/home.html'
    context_object_name = 'posts'
    ordering = ['-date_posted']
    paginate_by = 10


class UserPostListview(ListView):
    # model = Post
    model = User
    # template_name = 'blog/user_posts.html'
    template_name = 'users/profile-detail.html'
    context_object_name = 'selectedUser'

    # ordering = ['-date_posted']
    # paginate_by = 10

    def get_queryset(self):
        username = self.kwargs.get('username')
        # user = get_object_or_404(User, username=self.kwargs.get('username'))
        # return Profile.objects.filter(user=user).order_by('-date_posted')
        return User.objects.filter(username=username).first()
        # return user


class PostDetailView(DetailView):
    model = Post


class PostCreateView(LoginRequiredMixin, CreateView):
    model = Post
    fields = ['title', 'content']

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)


class PostUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    model = Post
    fields = ['title', 'content']

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)

    def test_func(self):
        post = self.get_object()
        if self.request.user == post.author:
            return True
        else:
            return False


class PostDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):
    model = Post
    success_url = '/'

    def test_func(self):
        post = self.get_object()
        if self.request.user == post.author:
            return True
        else:
            return False


def about(request):
    return render(request, 'blog/about.html', {'title': 'About'})


def redirectPage(request):
    if not request.user.is_authenticated:
        return redirect('/login')
    else:
        response = PostListview.as_view
        return redirect('/home')


def add_new_post(request):
    post_content = request.POST.get('post_content')

    upload_files = request.FILES.getlist('post_images')
    fs = FileSystemStorage()
    username = str(request.user)

    images = []

    for file in upload_files:
        destination = "/" + username + "/post/" + file.name
        path = settings.MEDIA_ROOT + destination
        fs.save(path, file)
        images.append(destination)

    post = Post(content=post_content, author_id=request.user.id, images=images)
    Post.save(post)

    data_response['success'] = "success"
    return JsonResponse(data_response)
