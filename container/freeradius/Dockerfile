FROM alpine:3.8

RUN apk add --no-cache tzdata

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.1"

RUN apk add --no-cache freeradius freeradius-eap

VOLUME /etc/raddb

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
