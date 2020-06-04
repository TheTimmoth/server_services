#!/bin/bash

run() {
  dhcpd -d -cf /etc/dhcp/dhcpd.conf
}

install() {
  sleep 365d
}
