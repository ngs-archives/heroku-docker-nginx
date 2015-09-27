Heroku nginx Docker Image
=========================

You need to install [Heroku Docker CLI plugin].

```sh
$ heroku plugin:install heroku-docker
```

Initialize your app
-------------------

```sh
$ echo 'web: service nginx start' > Procfile
$ mkdir www
$ echo '<html><body><h1>It works</h1></body></html>' > www/index.html
$ heroku docker:init --image atsnngs/heroku-nginx
$ docker-compose build
```

Start preview server
--------------------

```sh
$ docker-compose up web
$ open "http://$(docker-machine ip default):8080"
```

Release your site
-----------------

```sh
$ heroku create
$ heroku docker:release
$ heroku open
```

[Heroku Docker CLI plugin]: https://github.com/heroku/heroku-docker
