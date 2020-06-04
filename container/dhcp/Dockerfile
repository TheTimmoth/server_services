FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.3"

RUN apt-get install isc-dhcp-server -y && apt-get clean
RUN touch /var/lib/dhcp/dhcpd.leases

VOLUME /etc/dhcp
