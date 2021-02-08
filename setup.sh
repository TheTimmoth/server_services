#!/bin/bash

main() {

  #Edit settings
  if [[ $1 == "no_edit" ]]
  then
    echo -ne ""
  else
    read -n 1 -s -r -p "Press any key to open \"./docker_compose.yml\"..."
    editor settings.conf
  fi

  #Parse settings
  source settings.conf

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

  cat etc/docker-compose/ipv6-nat.yml >> docker-compose.yml
  echo "" >> docker-compose.yml
  cat etc/docker-compose/end.yml >> docker-compose.yml
  echo "" >> docker-compose.yml

}

main $1
