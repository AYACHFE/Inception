# #!/bin/bash
# # sleep 10
# # this line loads the variables in the .env file
# # . ./.env
# mysqld &
# while ! mysqladmin ping --silent; do
#     sleep 1
# done
# echo "MariaDB is running correctly."

# mysql -e "FLUSH PRIVILEGES;"
# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# # echo "------------------>"${SQL_ROOT_PASSWORD}
# # echo "------------------>"${SQL_DATABASE}
# # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"
# mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
# exec mysqld_safe



echo "script in\n";

mariadb-install-db  --user=mysql --datadir=/var/lib/mysql

cat << EOF > /tmp/init_db.sql

FLUSH PRIVILEGES;
ALTER USER '${MYSQL_USER_ROOT}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;

EOF
# echo "script out\n";
# cat /tmp/init_db.sql

# Flush privileges to apply changes
# Delete empty users (if any)
# Alter the root user's password
# Create a database if it doesn't exist
# Create a user if it doesn't exist, with a specified password
# Grant all privileges on a specific database to a user
# Flush privileges again to apply the new privileges


mariadbd --user=mysql --bootstrap < /tmp/init_db.sql

# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER '${MYSQL_USER_ROOT}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

exec mariadbd --user=mysql --bind-address=0.0.0.0