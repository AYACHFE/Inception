FROM debian:bookworm


RUN apt update && apt install -y mariadb-server

RUN mkdir -p /run/mysqld/ && chown -R mysql:mysql /run/mysqld/ && chmod 777 /run/mysqld/

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql && chmod 777 //var/lib/mysql

COPY /tools/script.sh /script.sh

EXPOSE 3306


ENTRYPOINT [ "sh", "script.sh" ]
