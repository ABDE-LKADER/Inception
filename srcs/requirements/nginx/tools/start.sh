#!/bin/sh

openssl req -x509 -out /etc/nginx/certificate.crt -keyout /etc/nginx/certificate.key \
  -newkey rsa:2048 -nodes -subj '/'

exec nginx