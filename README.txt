To import the JSON file:

1. Open terminal (make sure are in the correct virual environment)
2. Type: python manage.py shell
3. Type:

import json
from blog.models import Post
with open('posts.json') as f:
	posts_json = json.load(f)

for post in posts_json:
	post = Post(title=post['title'], content=post['content'], author_id=post['user_id'])
	post.save()


4. If you encounter an error with author_id, make sure you have
   users in your database that correspond to the "user_id" in
   the JSON file. If you don't, change the JSON file to reflect
   users in your database.