#!/bin/bash

run() {
  #Permission fix
  chown -R 201 /etc/freeradius/3.0
  find /etc/freeradius/3.0 -type d -exec chmod 755 {} +
  find /etc/freeradius/3.0 -type f -exec chmod 644 {} +

  radiusd -f -l stdout
}

install() {
}
