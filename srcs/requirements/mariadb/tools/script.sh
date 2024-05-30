#!/bin/bash

mariadb-install-db  --user=mysql --datadir=/var/lib/mysql

cat << EOF > /tmp/db_config.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
mariadbd --user=mysql --bootstrap < /tmp/db_config.sql
exec mariadbd --user=mysql --bind-address=0.0.0.0