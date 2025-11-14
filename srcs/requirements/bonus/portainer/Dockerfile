FROM alpine:3.21

RUN set -eux; \
    apk add --no-cache wget; \
    wget -q https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -O portainer.tar.gz; \
    tar xzf portainer.tar.gz -C /usr/local/bin --strip-components=1; \
    rm portainer.tar.gz

EXPOSE 9001
CMD ["portainer", "--data", "/var/portainer", "--bind", ":9001"]