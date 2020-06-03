#!/bin/sh

if [ $ENABLED -eq 1 ]; then
  if [ -f /etc/localtime ]; then
    rm /etc/localtime
  fi
  ln -s /usr/share/zoneinfo/${TIMEZONE:-"UTC"} /etc/localtime
  echo ${TIMEZONE:-"UTC"} > /etc/timezone

  dhcpd -d -cf /etc/dhcp/dhcpd.conf
else
  sleep 365d
fi
