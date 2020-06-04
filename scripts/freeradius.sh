#!/bin/bash

run() {
  #Permission fix
  chown -R :201 /etc/freeradius/3.0
  find /etc/freeradius/3.0 -type d -exec chmod g+s {} +
  find /etc/freeradius/3.0 -type d -exec chmod 775 {} +
  find /etc/freeradius/3.0 -type f -exec chmod 664 {} +

  freeradius -f -l stdout
}

install() {
  cp -r /etc/freeradius/3.0/* /template
  chown -R :201 /template
}
