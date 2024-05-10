FROM debian:buster
RUN apt-get update &&\
 apt-get install -y vim wget
RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client
#this will download wordpress from the site
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN chmod 777 /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod 777 wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# COPY wp-config.php /var/www/wordpress/wp-config-sample.php
COPY wp-config.php /var/www/wordpress/wp-config.php
###should be fixed
COPY tools/script.sh /script.sh
COPY tools/.env /.env
####
RUN chmod 777 /script.sh
EXPOSE 9000
CMD ["/script.sh"]
# CMD ["tail", "-f", "/dev/null"]