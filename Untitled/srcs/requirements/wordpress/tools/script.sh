#!/bin/bash
# sleep 5
. ./.env

echo "-----------------_________------------------"
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "wp-config.php does not exist, creating new file"
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'
else
    echo "wp-config.php exists, updating existing file"
    wp config set DB_NAME $SQL_DATABASE --allow-root --path='/var/www/wordpress'
    wp config set DB_USER $SQL_USER --allow-root --path='/var/www/wordpress'
    wp config set DB_PASSWORD $SQL_PASSWORD --allow-root --path='/var/www/wordpress'
    wp config set DB_HOST mariadb:3306 --allow-root --path='/var/www/wordpress'
fi