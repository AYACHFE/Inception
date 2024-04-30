FROM debian:latest

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MO/ST=TTH/L=M/O=1337/OU=1337/CN=aachfenn.42.fr/UID=aachfenn"

RUN mkdir -p /var/run/nginx

EXPOSE 9999

COPY /nginx.conf /etc/nginx/nginx.conf
COPY /website /usr/local/nginx/website

CMD ["nginx", "-g", "daemon off;"]
