FROM alpine:3.21

RUN set -eux; \
    apk add --no-cache wget; \
    wget -q https://github.com/portainer/portainer/releases/download/2.20.3/portainer-2.20.3-linux-amd64.tar.gz -O portainer.tar.gz; \
    tar xzf portainer.tar.gz -C /usr/local/bin --strip-components=1; \
    rm portainer.tar.gz

EXPOSE 9000
ENTRYPOINT ["portainer", "--data", "/var/portainer", "--bind", ":9000"]