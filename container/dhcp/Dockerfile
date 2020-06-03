FROM debian:buster

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.2"

RUN apt-get update && apt-get upgrade -y && apt-get install isc-dhcp-server -y && apt-get clean
RUN touch /var/lib/dhcp/dhcpd.leases

VOLUME /etc/dhcp

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
