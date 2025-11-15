FROM alpine:3.21

ARG FTP_USER
ARG FTP_PASS

RUN set -eux; \
    apk add --no-cache vsftpd; \
    mkdir -p /var/run/vsftpd/empty; \
    adduser --disabled-password --home /var/www/html/ $FTP_USER; \
    addgroup $FTP_USER nobody; \
    echo "$FTP_USER:$FTP_PASS" | chpasswd

COPY --chmod=644 conf/vsftpd.conf /etc/vsftpd/

EXPOSE 21 21000-21010
ENTRYPOINT [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]