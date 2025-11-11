FROM alpine:3.21

RUN set -eux; \
	apk add --no-cache nginx openssl

COPY --chmod=644 conf/nginx.conf /etc/nginx/
COPY --chmod=700 tools/start.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/start.sh" ]