#!/bin/bash

# Update script
# Version 1.0

main() {

  source .scripts/configure.sh

  printf "With this script you can look for updates or process an updated configuration file.\n"
  printf "What do you want to do?\n"
  printf "0) Update Configuration\n"
  # printf "1) Update server_services\n"
  printf "2) Exit\n"

  LEAVE=0
  while [ $LEAVE -eq 0 ]
  do

    read -p "[0|2]: " TEMP

    case $TEMP in
      0)
        updateDockerCompose
        LEAVE=1
        ;;
      # 1)
      #   :
      #   ;;
      2)
        LEAVE=1
        ;;
      *)
        :
        ;;
    esac
  done
}

main