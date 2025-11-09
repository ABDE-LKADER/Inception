#!/bin/sh

mariadb-install-db --user=mysql --datadir=/var/lib/mysql
exec mariadbd --user=mysql --bind-address=0.0.0.0 --port=3306
