FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.4"

RUN groupadd -r -g 202 bind && useradd -M -g 202 -u 202 -r bind && apt-get install bind9 -y && apt-get clean

VOLUME /etc/bind
