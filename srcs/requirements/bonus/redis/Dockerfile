FROM alpine:3.21

RUN set -eux; \
    apk add --no-cache redis

EXPOSE 6379
ENTRYPOINT [ "redis-server", "--bind", "0.0.0.0", \
             "--protected-mode", "no", "--maxmemory", "256mb", \
             "--maxmemory-policy", "allkeys-lru" ]