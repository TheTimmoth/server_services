#!/bin/bash

# Installation script

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
    echo "NET_IPv4_PREFIX=10.201.0" >> settings.conf
    echo "NET_IPv6_PREFIX=fd00::/80" >> settings.conf
    echo "NET_IPv6_NETMASK=64" >> settings.conf
    printf "\n# DNS settings\n" >> settings.conf
    echo "DNS_BINDING=53" >> settings.conf
    echo "DNS_BRIDGE_HOST=2" >> settings.conf
    printf "\n# DHCP settings\n" >> settings.conf
    echo "DHCP_BINDING=67" >> settings.conf
    echo "DHCP_BRIDGE_HOST=3" >> settings.conf
    printf "\n# FREERADIUS settings\n" >> settings.conf
    echo "FREERADIUS_BINDING=1812" >> settings.conf
    echo "FREERADIUS_BRIDGE_HOST=4" >> settings.conf
  fi
  source settings.conf
}

main() {}
  printf "Server services bundle\n"
  printf "Version 1.2\n"
  printf "Author: Tim Schlottmann\n"
  printf "\n"

  printf "Loading configuration...\n"
  configure

  LEAVE=0
  while [ $LEAVE -eq 0 ]
  do
    # printf "The default settings are designed to work out of the box.\n"
    read -p "Would you like to use default settings? [y|n] " TEMP
    case $TEMP in
      [yY] | [yY][eE][sS])
        printf "You can edit settings in file \"${PWD}/settings.conf\" at any time.\n"
        read -n 1 -s -r -p "Press any key to continue..."
        printf "\n"
        LEAVE=1
        ;;
      [nN] | [nN][oO])
        printf "Opening settings...\n"
        nano settings.conf
        LEAVE=1
        ;;
      *)
        :
        ;;
    esac
  done

  printf "Creating subdirectories...\n"
  mkdir -p volumes/dns
  mkdir -p volumes/dhcp
  mkdir -p volumes/freeradius

  #DHCP-Relay notification
  if [ $DHCP_ENABLED -eq 1 ]
  then
    printf "Please note that you need a DHCP-Relay-Agent for the dhcp server to function correctly.\n"
    printf "The relay should forward DHCP-Requests to the servers interface at port ${DHCP_BINDING}.\n"
    read -n 1 -s -r -p "Press any key to continue..."
    printf "\n"
  fi
}

main
