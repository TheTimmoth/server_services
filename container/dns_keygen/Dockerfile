FROM debian:buster

LABEL maintainer "Tim Schlottmann <tim@schlottmann.xyz>"

RUN apt update && apt upgrade -y
RUN apt install bind9utils -y

COPY run.sh /
RUN chmod 774 /run.sh

CMD ["/run.sh"]
