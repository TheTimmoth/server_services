#!/bin/bash

run() {
  #Permission fix
  chown -R 202 /etc/bind
  find /etc/bind -type d -exec chmod 775 {} +
  find /etc/bind -type f -exec chmod 664 {} +

  named -f -u bind
}

install() {
}
