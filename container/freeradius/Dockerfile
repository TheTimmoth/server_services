FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"
LABEL version="1.3"

RUN groupadd -r -g 201 freerad && useradd -M -g 201 -u 201 -r freerad && apt-get install freeradius -y && apt-get clean

VOLUME /etc/freeradius/3.0
