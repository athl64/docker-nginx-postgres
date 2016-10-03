docker-nginx-php-postgres
===========

## Features:

1. Nginx is configured to automatically resolve all domains ending with `.dev`.
It is very convenient: you can simply create the directory `test-app` (domain name without `.dev`) in the
web document root and it will be available by the link `http://test-app.dev/` (NOTICE: it requires some preliminary
configuration, see #additional software for detailed information).

2. Postgres 9.5
   * user: postgres
   * password: postgres

Web interface - Phppgadmin, accessible with http://local.dev/phppgadmin

2. Pre-installed `composer` (with assets plugin), `git`, `phpmyadmin` (by default, automatic login
as `root` without password).

3. It stores source codes and mysql data on the host machine, therefore, you don't need to deploy your app each
time you start the container.

4. Php process run by user with UID 1000 (by default, the same UID as your host machine user),
thus it can access all files. At the same time, you have all permissions for generated files.

# How to use this image

## additional software

For comfortable work, I suggest you to use [dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq) for automatic resolving of such domains as `http://*.dev/`.
You can install it in Ubuntu this way (run as `root`):

    apt-get install dnsmasq
    echo "address=/.dev/127.0.0.1" >> /etc/dnsmasq.conf

By default container binds `80` port on local `127.0.0.1:80`. If you are using another binding, change the
ip address in the previous code to the one you use.

Another variant is to update `/etc/hosts` manually, each time adding something like this:

    127.0.0.1   my-app.dev

## how to run container

First of all, you need install [Docker](https://www.docker.com/) on your machine. All command need run as root or you
need add your user to docker group.

    docker run -d --name=web-server -v /path-to-local-folder/www:/web  -p 127.0.0.1:80:80 dvixi/nginx-php7-postgres

`--name=web-server` set container name, for simple access to it in the future: you can start, restart and
stop the created container using its name: `docker start web-server`

`-p 127.0.0.1:80:80` bind the port `80` of the container to the port `80` on the host machine (on 127.0.0.1 localhost)

`-v /path-to-local-folder/www` bind mount a volume of source codes from host machine (`/path-to-local-folder/www`) to container (`/web`)

`-d` detached mode: run the container in the background and print the new container ID

!!! IMPORTANT!!!
Currently image has no volume for external (local) Postgres DB files data storage.

## how to access container terminal

You can access container terminal like this:

    docker exec -ti web-server su docker

It logs you in the container as special user `docker`, witch can work with source code and console commands.

But if you need `root` privileges, run:

    docker exec -ti web-server su root

It logs you in as `root`
