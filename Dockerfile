FROM alpine:3.10.2

RUN apk update                \
    && apk add apache2-utils  \
    && rm -rf /var/cache/apk/*