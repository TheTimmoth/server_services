#!/bin/bash

# Update script

SETTINGS_VERSION_LATEST="1.0"

update() {
  echo "Stop and remove containers..."
  docker-compose down --rmi all

  echo "Pulling newest version..."
  git pull

  echo "Recreate \"docker-compose.yml\"..."
  ./setup.sh no_edit

  echo "Update \"settings.conf\"..."
  update_settings

  echo "Rebuild and start containers..."
  docker-compose up --build --detach
  echo "Update finished..."
}

update_settings() {
  source ./settings.conf
  if [ -z $SETTINGS_VERSION ]
  then
    echo "  Detected versionless settings file..."
    echo "SETTINGS_VERSION=$SETTINGS_VERSION_LATEST" >> ./settings.conf

  # elif [ SETTINGS_VERSION == "1.0" ] then
  #   SETTINGS_VERSION_INT=1
  #   echo "  Detected settings file with version 1.0"
  #   echo "  Updating to version $SETTINGS_VERSION_LATEST"
  #   sed "s~SETTINGS_VERSION=1.0~SETTINGS_VERSION=$SETTINGS_VERSION_LATEST~" ./settings.conf
  fi

  #Detecting missing settings and add them if necessary
  # General settings
  if [ -z $DNS_ENABLED ]
  then
    echo "DNS_ENABLED=0" >> ./settings.conf
  fi
  if [ -z $DHCP_ENABLED ]
  then
    echo "DHCP_ENABLED=0" >> ./settings.conf
  fi
  if [ -z $FREERADIUS_ENABLED ]
  then
    echo "FREERADIUS_ENABLED=0" >> ./settings.conf
  fi

  if [ -z $TIMEZONE ]
  then
    echo "TIMEZONE=Europe/Berlin" >> ./settings.conf
  fi

  if [ -z $BUILD_DISABLED_CONTAINERS ]
  then
    echo "BUILD_DISABLED_CONTAINERS=0" >> ./settings.conf
  fi
}

main() {
  LEAVE=0
  while [ $LEAVE -eq 0 ]
  do
    read -p "Server services are going to be shutted down during update. Continue? [y|n] " TEMP
    case $TEMP in
      [yY] | [yY][eE][sS])
        update
        LEAVE=1
        ;;
      [nN] | [nN][oO])
        LEAVE=1
        ;;
      *)
        :
        ;;
    esac
  done
}

main
