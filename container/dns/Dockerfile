FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get clean

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.4"

RUN groupadd -r -g 202 bind && useradd -M -g 202 -u 202 -r bind && apt-get install bind9 -y && apt-get clean

VOLUME /etc/bind

COPY run.sh /
RUN chmod 774 /run.sh

ENTRYPOINT ["/run.sh"]
