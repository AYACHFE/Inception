FROM alpine:3.18
# FROM debian:bookworm

RUN apk update && apk add nginx openssl

WORKDIR /var/www/

RUN mkdir html

COPY default.conf /etc/nginx/http.d/

#get the certificat key
RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/aachfenn.key \
    -out /etc/nginx/ssl/aachfenn.crt  \
    -subj "/C=MA/L=Tetouan/O=Organization/CN=Company_name"

# EXPOSE 443
# -g specifies the config
CMD ["nginx", "-g", "daemon off;"]