FROM alpine:3.21

RUN set -eux; \
	apk add --no-cache nginx openssl

COPY --chmod=644 conf/nginx.conf /etc/nginx/

RUN openssl req -x509 -out /etc/nginx/certificate.crt \
	-keyout /etc/nginx/certificate.key \
  	-newkey rsa:2048 -nodes -subj '/'

ENTRYPOINT [ "nginx" ]