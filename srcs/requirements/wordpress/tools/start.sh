#!/bin/sh

if [ ! -x /usr/local/bin/wp ]; then
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
    chmod +x /usr/local/bin/wp
fi

if [ ! -f "/var/www/html/index.php" ]; then
    wget -q https://wordpress.org/latest.tar.gz -O - | tar -xzf - -C /var/www/html/ --strip-components=1
fi

wp config create --path=/var/www/html/ --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306


exec php-fpm83 -RF