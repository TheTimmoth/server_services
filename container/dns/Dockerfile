FROM alpine:3.8

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.1"

RUN apk add --no-cache bind bind-dnssec-tools

VOLUME /etc/bind

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
