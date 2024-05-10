#!/bin/bash
# sleep 5
. ./.env

wp config create	--allow-root \
			--dbname=$SQL_DATABASE \
			--dbuser=$SQL_USER \
			--dbpass=$SQL_PASSWORD \
			--dbhost=mariadb:3306 --path='/var/www/wordpress'

cat /var/www/wordpress/wp-config.php