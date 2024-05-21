#!/bin/bash

mkdir -p /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
cd /var/www/wordpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 777 wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root
wp config create --dbname=wordpress --dbuser=ayac --dbpass=ayac --dbhost=mariadb --allow-root
wp core install --url="localhost" --title="Inception" --admin_user=root --admin_password=root --admin_email=root@root.com --skip-email --allow-root
sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf

exec php-fpm8.2 -F