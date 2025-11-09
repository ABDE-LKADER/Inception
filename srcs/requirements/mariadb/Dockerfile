FROM alpine:3.21

RUN set -eux; \
	apk add --no-cache mariadb mariadb-client; \
	mkdir -p /run/mysqld /var/lib/mysql; \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY --chmod=644 conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf
COPY --chmod=700 tools/start.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/start.sh" ]