FROM alpine:3.8

RUN apk add --no-cache tzdata

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.2"

RUN apk add --no-cache bind

VOLUME /etc/bind

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
