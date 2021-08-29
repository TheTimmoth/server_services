FROM debian:bullseye-slim
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <coding@timsc.de>"
LABEL version="1.6"

RUN addgroup --system --gid 202 bind && adduser --system --disabled-password --no-create-home --uid 202 bind && adduser bind bind && apt-get install bind9 -y && apt-get clean

VOLUME /etc/bind
