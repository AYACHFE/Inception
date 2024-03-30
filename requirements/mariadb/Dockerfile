FROM debian:latest

RUN apt-get update
RUN apt-get install mariadb-server -y

COPY /50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
