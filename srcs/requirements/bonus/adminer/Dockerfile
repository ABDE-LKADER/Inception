FROM alpine:3.21

RUN set -eux; \
    apk add --no-cache wget php-fpm php-mysqli php-session; \
    mkdir -p /var/www/html; \
    wget -q https://www.adminer.org/latest.php -O /var/www/html/index.php

COPY --chmod=644 conf/www.conf /etc/php83/php-fpm.d/

EXPOSE 9000
ENTRYPOINT [ "php-fpm83", "-F" ]