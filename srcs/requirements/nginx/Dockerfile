# FROM alpine:3.18
FROM debian:bookworm


RUN apt update && apt install -y nginx openssl

WORKDIR /var/www/

RUN mkdir -p html

COPY /tools/default.conf /etc/nginx/nginx.conf

#get the certificat key
RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/aachfenn.key \
    -out /etc/nginx/ssl/aachfenn.crt  \
    -subj "/C=MA/L=Tetouan/O=Organization/CN=Company_name"


CMD ["nginx", "-g", "daemon off;"]