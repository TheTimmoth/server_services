#!/bin/bash

build_docker_compose(){
  #Build docker-compose.yml file
  echo "Build \"./docker_compose.yml\"..."
  cat etc/docker-compose/start.yml > docker-compose.yml
  echo "" >> docker-compose.yml

  if [[ $USE_IPV6_NAT_CONTAINER == "1" ]]
  then
    SOURCE_PATH=etc/docker-compose
  else
    SOURCE_PATH=etc/docker-compose_no_nat
  fi

  if [[ $DNS_ENABLED == "1" || $BUILD_DISABLED_CONTAINERS == "1" ]]
  then
    cat $SOURCE_PATH/dns.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  if [[ $DHCP_ENABLED == "1" || $BUILD_DISABLED_CONTAINERS == "1" ]]
  then
    cat $SOURCE_PATH/dhcp.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  if [[ $FREERADIUS_ENABLED == "1" || $BUILD_DISABLED_CONTAINERS == "1" ]]
  then
    cat $SOURCE_PATH/freeradius.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  if [[ $USE_IPV6_NAT_CONTAINER == "1" ]]
  then
    cat $SOURCE_PATH/ipv6-nat.yml >> docker-compose.yml
    echo "" >> docker-compose.yml
  fi

  cat $SOURCE_PATH/end.yml >> docker-compose.yml
  echo "" >> docker-compose.yml
}

update_nat() {
  if [[ -z $USE_IPV6_NAT_CONTAINER ]]
  then
    LEAVE=0
    while [ $LEAVE -eq 0 ]
    do
      read -p "Do you want to enable experimental IPv6 NAT? [y|n] " TEMP
      case $TEMP in
        [yY] | [yY][eE][sS])
          USE_IPV6_NAT_CONTAINER=0
          LEAVE=1
          ;;
        [nN] | [nN][oO])
          USE_IPV6_NAT_CONTAINER=1
          LEAVE=1
          ;;
        *)
          :
          ;;
      esac
    done

    if [[ $USE_IPV6_NAT_CONTAINER = 0 ]]
    then
      NAT_CONFIG=''
      echo {\"ipv6\":true\,\"fixed-cidr-v6\":\"${NET_IPv6_PREFIX:-fd1a:2b17:1d42:cddd:}:/${NET_IPv6_NETMASK:-80}\"\,\"experimental\":true\,\"ip6tables\":true} > /etc/docker/daemon.json
    fi
  fi
}

main() {
  #Parse settings
  source settings.conf

  update_nat

  build_docker_compose
}

main $1
