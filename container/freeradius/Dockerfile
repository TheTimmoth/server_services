FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get clean

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.3"

RUN groupadd -r -g 201 freerad && useradd -M -g 201 -u 201 -r freerad && apt-get install freeradius -y && apt-get clean

VOLUME /etc/freeradius/3.0

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
