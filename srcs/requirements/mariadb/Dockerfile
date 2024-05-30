FROM debian:bookworm


RUN apt update && apt install -y mariadb-server mariadb-client

RUN mkdir -p /run/mysqld/ && chown -R mysql:mysql /run/mysqld/ && chmod 777 /run/mysqld/

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql && chmod 777 /var/lib/mysql

COPY /tools/script.sh /script.sh

RUN chmod 777 script.sh

EXPOSE 3306

CMD "./script.sh"
