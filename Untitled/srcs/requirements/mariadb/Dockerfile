FROM debian:latest

RUN apt-get update &&\
 apt-get install -y mariadb-server vim

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
###should be fixed
COPY tools/script.sh /script.sh
COPY tools/.env /.env
####
RUN chmod 777 /script.sh
# i should create a volume and give it to the mariadb container to store the data in it
# this step is done when running the container "{docker run -v my_volume:/var/lib/mysql -d your_image_name}"
# i think that after this step will be done in the docker-compose

RUN mkdir -p /run/mysqld/ && chown -R mysql:mysql /run/mysqld/
CMD ["/script.sh"]

# CMD ["tail", "-f", "/dev/null"]