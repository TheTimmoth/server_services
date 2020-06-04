#!/bin/bash

run() {
  dhcpd -d -cf /etc/dhcp/dhcpd.conf
}

install() {
  cp -r /etc/dhcp/* /template
}
