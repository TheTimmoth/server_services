#!/bin/bash

# Update script
# Version 1.0.191219

main() {

  source .scripts/configure.sh

  printf "With this script you can look for updates or process an updated configuration file.\n"
  printf "What do you want to do?\n"
  printf "0) Update Configuration\n"
  printf "1) Update server_services\n"
  printf "2) Exit\n"

  read -p "[0|1|2]: " TEMP

  case $TEMP in
    0)
      updateDockerCompose
      ;;
    1)
      :
      ;;
    2)
      exit 0
      ;;
    *)
      :
      ;;
  esac
  done
}

main