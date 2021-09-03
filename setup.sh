#!/bin/bash

get_settings() {
  # Parse existing settings
  source settings.conf

  # Add eventually missing variables

  # General settings
  if [ -z $SETTINGS_VERSION ]
  then
    SETTINGS_VERSION=1.0
  fi
  if [ -z $DNS_ENABLED ]
  then
    DNS_ENABLED=0
  fi
  if [ -z $DHCP_ENABLED ]
  then
    DHCP_ENABLED=0
  fi
  if [ -z $FREERADIUS_ENABLED ]
  then
    FREERADIUS_ENABLED=0
  fi

  if [ -z $TIMEZONE ]
  then
    TIMEZONE="Europe/Berlin"
  fi

  if [ -z $BUILD_DISABLED_CONTAINERS ]
  then
    BUILD_DISABLED_CONTAINERS=0
  fi

}

cleanup_settings() {
  cp etc/settings.template settings.conf
  sed -i "s~%%SETTINGS_VERSION%%~$SETTINGS_VERSION~g" ./settings.conf
  sed -i "s~%%DNS_ENABLED%%~$DNS_ENABLED~g" ./settings.conf
  sed -i "s~%%DHCP_ENABLED%%~$DHCP_ENABLED~g" ./settings.conf
  sed -i "s~%%FREERADIUS_ENABLED%%~$FREERADIUS_ENABLED~g" ./settings.conf
  sed -i "s~%%TIMEZONE%%~$TIMEZONE~g" ./settings.conf
  sed -i "s~%%BUILD_DISABLED_CONTAINERS%%~$BUILD_DISABLED_CONTAINERS~g" ./settings.conf
}

build_docker_compose(){
  #Build docker-compose.yml file
  echo "Build \"./docker_compose.yml\"..."
  cat etc/docker-compose/start.yml > docker-compose.yml
  echo "" >> docker-compose.yml

  if [[ $DNS_ENABLED == "1" || $BUILD_DISABLED_CONTAINERS == "1" ]]
  then
    cat etc/docker-compose/dns.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  if [[ $DHCP_ENABLED == "1" || $BUILD_DISABLED_CONTAINERS == "1" ]]
  then
    cat etc/docker-compose/dhcp.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  if [[ $FREERADIUS_ENABLED == "1" || $BUILD_DISABLED_CONTAINERS == "1" ]]
  then
    cat etc/docker-compose/freeradius.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  cat etc/docker-compose/end.yml >> docker-compose.yml
  echo "" >> docker-compose.yml
}

main() {
  cd $( cd $(dirname $0) && pwd )

  get_settings
  cleanup_settings

  build_docker_compose
}

main
