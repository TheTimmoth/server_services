FROM debian:bullseye-slim
RUN apt-get update && apt-get upgrade -y && apt-get clean

RUN mkdir /scripts && mkdir /template
VOLUME /scripts
VOLUME /template

CMD [ "run" ]
ENTRYPOINT ["/scripts/container.sh"]

LABEL maintainer "Tim Schlottmann <coding@timsc.de>"
LABEL version="1.1"

RUN apt-get install ejabberd -y && apt-get clean

VOLUME /etc/ejabberd
