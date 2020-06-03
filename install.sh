#!/bin/bash

# Installation script

printf "Server services bundle\n"
printf "Version 1.2\n"
printf "Author: Tim Schlottmann\n"
printf "\n"

source .scripts/configure.sh

printf "Loading configuration...\n"
configure

LEAVE=0
while [ $LEAVE -eq 0 ]
do
  # printf "The default settings are designed to work out of the box.\n"
  read -p "Would you like to use default settings? [y|n] " TEMP
  case $TEMP in
    [yY] | [yY][eE][sS])
      printf "You can edit settings in file \"settings.conf\" at any time.\n"
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
  printf "The relay should forward DHCP-Requests to ${DHCP_LISTENING_ADDRESS}:${DHCP_LISTENING_PORT}\n"
  read -n 1 -s -r -p "Press any key to continue..."
  printf "\n"
fi
