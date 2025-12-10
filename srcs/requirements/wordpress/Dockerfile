FROM alpine:3.21

RUN set -eux; \
	apk add --no-cache php wget php-fpm php-phar php-curl php-mysqli php-iconv php-tokenizer; \
	mkdir -p /var/www/html

COPY --chmod=644 conf/www.conf /etc/php83/php-fpm.d/
COPY --chmod=700 tools/start.sh /usr/local/bin/

EXPOSE 9000
ENTRYPOINT [ "/usr/local/bin/start.sh" ]