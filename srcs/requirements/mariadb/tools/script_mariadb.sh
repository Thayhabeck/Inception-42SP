#!/bin/ash

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

mariadbd-safe &

sleep 8

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_NAME; \
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD'; \
GRANT ALL ON $MYSQL_NAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD'; \
ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
FLUSH PRIVILEGES;"

echo "MariaDB configuration complete."
