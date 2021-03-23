#!/bin/bash

# Installation script

configure() {

  if [ -f /etc/timezone ]
  then
    TIMEZONE=$(cat /etc/timezone)
  elif [ -f /etc/localtime ]
  then
    TIMEZONE=$(ls -l /etc/localtime | sed -n "s#^.*zoneinfo/\(.*$\)#\1#p")
  fi

  if [ ! -f settings.conf ]
  then
    cp etc/settings.template ./settings.conf
  fi
  source settings.conf
}

main() {
  printf "Server services bundle\n"
  printf "Version 1.3\n"
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

  printf "Gathering config files...\n"
  docker run --rm -v ${PWD}/scripts:/scripts -v ${PWD}/volumes/dns:/template -e "SERVICE=DNS" server_dns:1.5 install
  docker run --rm -v ${PWD}/scripts:/scripts -v ${PWD}/volumes/dhcp:/template -e "SERVICE=DHCP" server_dhcp:1.3 install
  docker run --rm -v ${PWD}/scripts:/scripts -v ${PWD}/volumes/freeradius:/template -e "SERVICE=FREERADIUS" server_freeradius:1.3 install
  docker run --rm -v ${PWD}/scripts:/scripts -v ${PWD}/volumes/ejabberd:/template -e "SERVICE=EJABBERD" server_ejabberd:1.0 install

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
