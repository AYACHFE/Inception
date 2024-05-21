# FROM debian:latest

# RUN apt-get update
# RUN apt-get install -y nginx
# RUN apt-get install -y vim
# RUN mkdir -p /etc/nginx/ssl
# RUN apt-get install -y openssl
# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MO/ST=TTH/L=M/O=1337/OU=1337/CN=aachfenn.42.fr/UID=aachfenn"

# RUN mkdir -p /var/run/nginx

# EXPOSE 443

# COPY /default.conf /etc/nginx/http.d/

# # COPY /website /usr/local/nginx/website

# CMD ["nginx", "-g", "daemon off;"]


FROM alpine:3.18

# get nginx and openssl
# -y force yes
RUN apk update && apk add nginx openssl

WORKDIR /var/www/

RUN mkdir html

# RUN chown www-data:www-data /var/www/html/

COPY default.conf /etc/nginx/http.d/

#get the certificat key
RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/aachfenn.key \
    -out /etc/nginx/ssl/aachfenn.crt  \
    -subj "/C=MA/L=Tetouan/O=42/OU=1337 MED/CN=aachfenn.42.fr"

EXPOSE 443



# "nginx": This is the main executable or binary to be executed. 
# It refers to the Nginx web server.
# "-g": This is an argument for Nginx, used to pass global configurations.
# "daemon off;": This is a configuration option for Nginx that tells it to run in the foreground
#  rather than as a background daemon. This is commonly used in Docker containers to ensure that
#  the container does not exit immediately after starting.
CMD ["nginx", "-g", "daemon off;"]