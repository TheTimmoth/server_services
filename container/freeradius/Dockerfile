FROM debian:bullseye-slim
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <coding@timsc.de>"
LABEL version="1.4"

RUN groupadd -r -g 201 freerad && useradd -M -g 201 -u 201 -r freerad && apt-get install freeradius -y && apt-get clean

VOLUME /etc/freeradius/3.0
