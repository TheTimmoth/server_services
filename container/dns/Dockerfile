FROM debian:buster
RUN echo "deb http://deb.debian.org/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list && apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <coding@timsc.de>"
LABEL version="1.5"

#RUN groupadd -r -g 202 bind && useradd -M -g 202 -u 202 -r bind && apt-get install -t buster-backports bind9 -y && apt-get clean
RUN addgroup --system --gid 202 bind && adduser --system --disabled-password --no-create-home --uid 202 bind && adduser bind bind && apt-get install -t buster-backports bind9 -y && apt-get clean

VOLUME /etc/bind
