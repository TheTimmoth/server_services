#!/bin/bash

run() {
  #Permission fix
  chown -R :202 /etc/bind
  find /etc/bind -type d -exec chmod g+s {} +
  find /etc/bind -type d -exec chmod 775 {} +
  find /etc/bind -type f -exec chmod 664 {} +
  find /etc/bind -type f -name "*.sh" -exec chmod 774 {} +

  named -f -u bind
}

install() {
  cp -r /etc/bind/* /template
  chown -R :202 /template
}
