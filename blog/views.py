# Django Tutorials 3 of 17
# django created a shortcut for HTTP rendering
# called render
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib.auth.models import User
from django.views.generic import (
    ListView,
    DetailView,
    CreateView,
    UpdateView,
    DeleteView,
)
from .models import Post

# Django Tutorials 3 of 17
# dummy data
posts = [
    {
        'author': 'Jason Green',
        'title': 'Blog Post 1',
        'content': 'First Post Content',
        'date_posted': 'Some time'
    },
    {
        'author': 'Smack me',
        'title': 'Blog Post 2',
        'content': 'Second Post Content',
        'date_posted': 'Yesterday'
    }
]

def home(request):
    # Django Tutorials 3 of 17
    # dictionary called "context" with a key called "posts" and
    # the second "posts" is the dictionary above
    context = {
        # Django Tutorials 3 of 17
        # 'posts': posts
        'posts': Post.objects.all()
    }
    # Django Tutorials 3 of 17
    # return() takes "request" object as first argument, then the template
    # name and referenced by subdirectory in app directory (called blog)
    # "context" is an optional argument. It allows us to pass information
    # into our template.
    # VIEWS need to either return an HTTP Response, or an Exception
    return render(request, 'blog/home.html', context)



class PostListview(ListView):
    model = Post
    template_name = 'blog/home.html'
    context_object_name = 'posts'
    ordering = ['-date_posted']
    paginate_by = 10

class UserPostListview(ListView):
    model = Post
    template_name = 'blog/user_posts.html'
    context_object_name = 'posts'
    # ordering = ['-date_posted']
    paginate_by = 10



    def get_queryset(self):
        user = get_object_or_404(User, username=self.kwargs.get('username'))
        return Post.objects.filter(author=user).order_by('-date_posted')

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
# Django Tutorials 3 of 17
# Django Tutorials 2 of 17
# this function will send the user to 'blog/about.html' template
# you need to make sure the urls.py has the views.about call in the
# path() function
def about(request):
    return render(request, 'blog/about.html', {'title': 'About'})