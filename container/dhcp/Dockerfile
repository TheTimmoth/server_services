FROM alpine:3.8

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"

RUN mkdir -p /config/dhcp-key

COPY run.sh /config/
RUN chmod 774 /config/run.sh

RUN apk add --no-cache dhcp
RUN touch /var/lib/dhcp/dhcpd.leases

VOLUME /etc/dhcp
VOLUME /config/dhcp-key

ENTRYPOINT ["/config/run.sh"]
