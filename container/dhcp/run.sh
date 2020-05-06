#!/bin/sh

if [ $ENABLED -eq 1 ]
then
  dhcpd -d -cf /etc/dhcp/dhcpd.conf
else
  sleep 365d
fi