FROM alpine:3.21

RUN set -eux; \
    apk add --no-cache nginx; \
    mkdir -p /var/www/html;

COPY --chmod=644 conf/nginx.conf /etc/nginx/nginx.conf
COPY --chmod=644 tools/ /var/www/html/

EXPOSE 80
ENTRYPOINT [ "nginx" ]