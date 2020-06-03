FROM alpine:3.8

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.0"

RUN apk add --no-cache dhcp
RUN touch /var/lib/dhcp/dhcpd.leases

VOLUME /etc/dhcp

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
