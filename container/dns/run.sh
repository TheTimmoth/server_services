#!/bin/sh

if [ $ENABLED -eq 1 ]; then
  if [ -f /etc/localtime ]; then
    rm /etc/localtime
  fi
  ln -s /usr/share/zoneinfo/${TIMEZONE:-"UTC"} /etc/localtime
  echo ${TIMEZONE:-"UTC"} > /etc/timezone

  named -f
else
  sleep 365d
fi
