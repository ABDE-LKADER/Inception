FROM alpine:3.21

RUN set -eux; \
	apk add --no-cache mariadb; \
	mkdir -p /run/mysqld /var/lib/mysql; \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

# ENTRYPOINT [ "start.sh" ]

# /home/$USER/data/mariadb > /var/lib/mysql/ > rw

# Installing MariaDB/MySQL system tables in '/var/lib/mysql'
# mariadb-install-db \
#   --user=mysql \
#   --datadir=/var/lib/mysql \
#   --skip-test-db \
#   --auth-root-authentication-method=normal
