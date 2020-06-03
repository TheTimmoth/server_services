#!/bin/bash

# Configuration loading and updating script

configure() {

  if [ -f /etc/timezone ]; then
    TIMEZONE=$(cat /etc/timezone)
  elif [ -f /etc/localtime ]; then
    TIMEZONE=$(ls -l /etc/localtime | sed -n "s#^.*zoneinfo/\(.*$\)#\1#p")
  fi

  if [ ! -f settings.conf ]; then
    printf "No settings file detectes. Creating new one...\n"
    printf "#########################################################\n" > settings.conf
    printf "# server_services configuration file\n" >> settings.conf
    printf "#########################################################\n" >> settings.conf
    printf "\n# General settings\n" >> settings.conf
    echo "DNS_ENABLED=1" >> settings.conf
    echo "DHCP_ENABLED=1" >> settings.conf
    echo "FREERADIUS_ENABLED=1" >> settings.conf
    echo "" >> settings.conf
    echo "TIMEZONE=${TIMEZONE:-"UTC"}" >> settings.conf
    printf "\n# Docker settings\n" >> settings.conf
    echo "NET_IPv4_SUBNET=10.201.0" >> settings.conf
    echo "NET_IPv6_PREFIX=fd00::/80" >> settings.conf
    echo "NET_IPv6_NETMASK=64" >> settings.conf
    printf "\n# DNS settings\n" >> settings.conf
    echo "DNS_LISTENING_ADDRESS=$IP_ADDRESS" >> settings.conf
    echo "DNS_BINDING=53" >> settings.conf
    echo "DNS_BRIDGE_HOST=2" >> settings.conf
    printf "\n# DHCP settings\n" >> settings.conf
    echo "DHCP_LISTENING_ADDRESS=$IP_ADDRESS" >> settings.conf
    echo "DHCP_BINDING=67" >> settings.conf
    echo "DHCP_BRIDGE_HOST=3" >> settings.conf
    printf "\n# FREERADIUS settings\n" >> settings.conf
    echo "FREERADIUS_LISTENING_ADDRESS=$IP_ADDRESS" >> settings.conf
    echo "FREERADIUS_BINDING=1812" >> settings.conf
    echo "FREERADIUS_BRIDGE_HOST=4" >> settings.conf
  fi
  source settings.conf
}
