FROM heroku/cedar:14

RUN \
  apt-get update -y && \
  apt-get install -y software-properties-common python-software-properties && \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update -y

RUN apt-get -y install nginx

RUN echo 'user www-data;\n\
daemon off;\n\
worker_processes auto;\n\
pid /run/nginx.pid;\n\
\n\
events {\n\
  worker_connections 768;\n\
}\n\
\n\
http {\n\
  sendfile on;\n\
  tcp_nopush on;\n\
  tcp_nodelay on;\n\
  keepalive_timeout 65;\n\
  types_hash_max_size 2048;\n\
\n\
  include /etc/nginx/mime.types;\n\
  default_type application/octet-stream;\n\
\n\
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE\n\
  ssl_prefer_server_ciphers on;\n\
\n\
  access_log /var/log/nginx/access.log;\n\
  error_log /var/log/nginx/error.log;\n\
\n\
  gzip on;\n\
  gzip_disable "msie6";\n\
\n\
  server {\n\
    listen 8080 default_server;\n\
    listen [::]:8080 default_server;\n\
\n\
    root /app/user/www;\n\
    server_name _;\n\
\n\
    location / {\n\
      try_files $uri $uri/ =404;\n\
    }\n\
  }\n\
}' > /etc/nginx/nginx.conf

WORKDIR /app/user
ONBUILD ADD . /app/user/
