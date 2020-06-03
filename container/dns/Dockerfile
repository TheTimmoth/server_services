FROM alpine:3.12

RUN apk add --no-cache tzdata

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.3"

RUN addgroup -S -g 202 named && adduser -S -D -H -G named -u 202 named && apk add --no-cache bind

VOLUME /etc/bind

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
