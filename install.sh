#!/bin/bash

# Installation script
# Version 1.0.200506

printf "Server services bundle\n"
printf "Version 1.0.200506\n"
printf "Author: Tim Schlottmann\n"
printf "\n"

source .scripts/configure.sh

LEAVE=0
while [ $LEAVE -eq 0 ]
do
  printf "The default settings are designed to work out of the box.\n"
  read -p "Would you like to change settings first? [y|n] " TEMP
  case $TEMP in
    [yY] | [yY][eE][sS])
      printf "Opening settings...\n"
      nano settings.conf
      printf "Please edit the settings for the services after this script is finished.\n"
      read -n 1 -s -r -p "Press any key to continue..."
      printf "\n"
      LEAVE=1
      ;;
    [nN] | [nN][oO])
      printf "Please edit the settings for the services after this script is finished.\n"
      read -n 1 -s -r -p "Press any key to continue..."
      printf "\n"
      LEAVE=1
      ;;
    *)
      :
      ;;
  esac
done

printf "Loading configuration...\n"
configure
printf "Updating ./docker-compose.yml...\n"
updateDockerCompose

printf "Creating subdirectories...\n"
mkdir -p volumes/dhcp
mkdir -p volumes/dns

#DHCP-Relay notification
if [ $DHCP_ENABLED -eq 1 ]
then
  printf "Please note that you need a DHCP-Relay-Agent for this tool to function correctly.\n"
  printf "The relay should forward DHCP-Requests to ${DHCP_LISTENING_ADDRESS}:${DHCP_LISTENING_PORT}\n"
  read -n 1 -s -r -p "Press any key to continue..."
  printf "\n"
fi