#!/bin/sh

if [ ! -d /var/lib/mysql/mysql ]; then
mariadb-install-db --user=mysql --skip-test-db; fi

cat << EOF > /var/lib/mysql/init.sql
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOF

exec mariadbd --user=mysql