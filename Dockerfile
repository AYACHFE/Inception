
FROM debian:latest

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

COPY /nginx.conf /etc/nginx/nginx.conf
COPY /website /usr/local/nginx/website

