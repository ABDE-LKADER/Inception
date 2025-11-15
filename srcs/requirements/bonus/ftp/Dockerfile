FROM alpine:3.21

RUN set -eux; \
    apk add --no-cache vsftpd; \
    mkdir -p /var/run/vsftpd/empty

COPY --chmod=644 conf/vsftpd.conf /etc/vsftpd/
COPY --chmod=700 tools/start.sh /usr/local/bin/

EXPOSE 21 21000-21010
ENTRYPOINT [ "/usr/local/bin/start.sh" ]

# FROM debian:bookworm-slim

# RUN set -eux; \
#     apt-get update; \
#     apt-get install -y vsftpd; \
#     mkdir -p /var/run/vsftpd/empty; \
#     rm -fr /var/lib/apt/lists/*

# COPY --chmod=644 conf/vsftpd.conf /etc/vsftpd/
# COPY --chmod=700 tools/start.sh /usr/local/bin/

# EXPOSE 21 21000-21010
# ENTRYPOINT [ "/usr/local/bin/start.sh" ]
