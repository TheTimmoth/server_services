#!/bin/bash

timezone() {
  #Set timezone
  if [ -f /etc/localtime ]; then
    rm /etc/localtime
  fi
  ln -s /usr/share/zoneinfo/${TIMEZONE:-"UTC"} /etc/localtime
  echo ${TIMEZONE:-"UTC"} > /etc/timezone
}
