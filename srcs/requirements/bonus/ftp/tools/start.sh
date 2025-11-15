#!/bin/bash

adduser --disabled-password --home /var/www/html $FTP_USER
addgroup $FTP_USER nobody;
echo "$FTP_USER:$FTP_PASS" | chpasswd

vsftpd /etc/vsftpd/vsftpd.conf