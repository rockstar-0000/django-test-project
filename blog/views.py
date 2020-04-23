from django.shortcuts import render, get_object_or_404
from django.contrib.auth import views as auth_views
from django.contrib.auth.views import LoginView as DefaultLoginView
from django.conf import settings
from django.db.models import Q
from django.core import serializers
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
from .models import Comment
from users.models import Profile
from users.models import Friend

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
    # ordering = ['id']
    paginate_by = 10

    def get_queryset(self):
        userId = self.request.user.id
        friends_list = Friend.objects.filter((Q(state="Accept") | Q(state="New_Accept")) & (Q(sender_id=userId) | Q(recipient_id=userId)))

        query = Q(state="public") | Q(author_id=userId)

        for friend in friends_list:
            if friend.sender_id == userId:
                print(friend.recipient_id)
                query = query | Q(state="private", author_id=int(friend.recipient_id))
            elif friend.recipient_id == userId:
                print(friend.sender_id)
                query = query | Q(state="private", author_id=int(friend.sender_id))

        return Post.objects.filter(query).order_by("-id")


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
    public_private = request.POST.get('public_private')

    upload_files = request.FILES.getlist('post_images')
    fs = FileSystemStorage()
    username = str(request.user)

    images = []

    for file in upload_files:
        destination = "/" + username + "/post/" + file.name
        path = settings.MEDIA_ROOT + destination
        fs.save(path, file)
        images.append(destination)

    post = Post(content=post_content, author_id=request.user.id, images=images, state=public_private)
    Post.save(post)

    data_response['success'] = "success"
    return JsonResponse(data_response)

def add_new_comment(request):
    username = str(request.user)
    postId = request.POST.get('postId')
    comment_text = request.POST.get('comment_text')
    comment_image = request.FILES.get('comment_image')
    fs = FileSystemStorage()

    destination = ""

    if comment_image != None:
        destination = "/" + username + "/comment/" + str(comment_image)
        path = settings.MEDIA_ROOT + destination
        fs.save(path, comment_image)

    comment = Comment(content=comment_text, author_id=request.user.id, image=destination, post_id=postId)
    Comment.save(comment)

    new_comment_id = Comment.objects.filter(post_id=postId, author_id=request.user.id).last().id
    new_comment_queryset = Comment.objects.filter(id=new_comment_id)
    new_comment = serializers.serialize('json', new_comment_queryset)
    data_response['comment'] = new_comment
    return HttpResponse(new_comment, content_type="text/json-command-filtered")

def get_comments(request):
    postId = request.POST.get('postId')
    # print(postId)
    data_response['success'] = "success"
    return Comment.objects.filter(post_id=postId)

def upvote(request):
    if request.method == 'POST':
        userId = request.user.id
        postId = request.POST.get('postId')
        selectedUserId = request.POST.get('selectedUserId')
        post = Post.objects.get(pk=postId)
        if post.like is not None:
            for like in post.like:
                if like == int(userId):
                    data_response['success'] = 'failed'
                    return JsonResponse(data_response)

            post.like += [int(userId)]
            data_response['num_upvotes'] = len(post.like)

        else:
            new_list = list()
            new_item = new_list + [int(userId)]
            post.like = new_item
            data_response['num_upvotes'] = 1
            data_response['num_downvotes'] = 0
            data_response['success'] = 'success'

        if post.dislike is not None:
            for dislike in post.dislike:
                if dislike == int(userId):
                    post.dislike.remove(dislike)
                    data_response['success'] = 'minus_downvote'
            data_response['num_downvotes'] = -(len(post.dislike))

        post.save()
        return JsonResponse(data_response)

def downvote(request):
    if request.method == 'POST':
        userId = request.user.id
        postId = request.POST.get('postId')
        selectedUserId = request.POST.get('selectedUserId')
        post = Post.objects.get(pk=postId)
        if post.dislike is not None:
            for dislike in post.dislike:
                if dislike == int(userId):
                    data_response['success'] = 'failed'
                    return JsonResponse(data_response)

            post.dislike += [int(userId)]
            data_response['num_downvotes'] = -(len(post.dislike))

        else:
            new_list = list()
            new_item = new_list + [int(userId)]
            post.dislike = new_item
            data_response['num_upvotes'] = 0
            data_response['num_downvotes'] = -1
            data_response['success'] = 'success'

        if post.like is not None:
            for like in post.like:
                if like == int(userId):
                    post.like.remove(like)
                    data_response['success'] = 'minus_upvote'
            data_response['num_upvotes'] = len(post.like)

        post.save()
        return JsonResponse(data_response)
