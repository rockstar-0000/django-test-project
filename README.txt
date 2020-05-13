1. install docker

2. open up the git directory (the directory this file is in) in the terminal "cd xxx"

3. run this command to create the docker instance:   docker-compose up -d --build

4. pressing control-c will exit docker

Commands:
"docker-compose up -d --build" -- build docker instance
"docker-compose down" -- delete docker instance, but not volumes
"docker-compose down -v" -- delete docker instance and volumes (no need to delete tables for make migrations)
"docker-compose exec web python manage.py migrate --noinput" -- basic way to run commands 

Tips:

You also can go onto docker-desktop -> Dashboard -> Click the instance that's green (running docker instance)
and open a linux terminal for each instance (Web, and db).
