#!/bin/bash

mkdir -p /var/www/wordpress
#thid command changes the user and the group to www-data because 
#www-data is the user and the group that nginx uses to run by default
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
cd /var/www/wordpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 777 wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root
wp config create --dbname="${SQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MY_SQL_HOST_}" --allow-root
wp core install --url="${DOMAIN_NAME}" --title="Inception" --admin_user="${MYSQL_USER_ROOT}" --admin_password="${MYSQL_ROOT_PASSWORD}" --admin_email="${MYSQL_EMAIL}" --skip-email --allow-root
wp user create "${MYSQL_USER}" "${MYSQL_ROOT_EMAIL}" --role=editor --user_pass="${MYSQL_PASSWORD}" --allow-root
sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf

exec php-fpm8.2 -F