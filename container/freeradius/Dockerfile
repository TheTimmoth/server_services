FROM alpine:3.12

RUN apk add --no-cache tzdata

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.2"

RUN addgroup -S -g 201 radius && adduser -S -D -H -G radius -u 201 radius && apk add --no-cache freeradius freeradius-eap

VOLUME /etc/raddb

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
