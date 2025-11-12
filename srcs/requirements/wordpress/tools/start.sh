#!/bin/sh

if [ ! -x /usr/local/bin/wp ]; then
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
    chmod +x /usr/local/bin/wp
fi

cd /var/www/html
if [ ! -f "index.php" ]; then
    wget -q https://wordpress.org/latest.tar.gz -O - | tar -xzf - -C . --strip-components=1
fi

if [ ! -f "wp-config.php" ]; then
wp config create --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb:3306

wp core install --url=$WP_URL \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASS \
    --admin_email=$WP_ADMIN_EMAIL

wp user create $WP_USER $WP_USER_EMAIL \
    --role='subscriber' \
    --user_pass=$WP_USER_PASS
fi

exec php-fpm83 -RF