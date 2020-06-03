#!/bin/sh

if [ $ENABLED -eq 1 ]; then
  #Set timezone
  if [ -f /etc/localtime ]; then
    rm /etc/localtime
  fi
  ln -s /usr/share/zoneinfo/${TIMEZONE:-"UTC"} /etc/localtime
  echo ${TIMEZONE:-"UTC"} > /etc/timezone

  #Permission fix
  chown -R 202 /etc/bind
  find /etc/bind -type d -exec chmod 775 {} +
  find /etc/bind -type f -exec chmod 664 {} +

  named -f -u named
else
  sleep 365d
fi
