# #!/bin/bash

echo "script in\n";

mariadb-install-db  --user=mysql --datadir=/var/lib/mysql

cat << EOF > /tmp/init_db.sql


FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;

EOF
mariadbd --user=mysql --bootstrap < /tmp/init_db.sql
exec mariadbd --user=mysql --bind-address=0.0.0.0