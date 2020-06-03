#!/bin/sh

if [ $ENABLED -eq 1 ]; then
  #Set timezone
  if [ -f /etc/localtime ]; then
    rm /etc/localtime
  fi
  ln -s /usr/share/zoneinfo/${TIMEZONE:-"UTC"} /etc/localtime
  echo ${TIMEZONE:-"UTC"} > /etc/timezone

  #Permission fix
  chown -R 201 /etc/raddb
  find /etc/raddb -type d -exec chmod 755 {} +
  find /etc/raddb -type f -exec chmod 644 {} +

  radiusd -f -l stdout
else
  sleep 365d
fi
