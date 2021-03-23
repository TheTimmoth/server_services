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
  if [ -z SETTINGS_VERSION ]
  then
    echo "  Detected versionless settings file..."
    echo "SETTINGS_VERSION=$SETTINGS_VERSION_LATEST" >> ./settings.conf

  # elif [ SETTINGS_VERSION == "1.0" ] then
  #   SETTINGS_VERSION_INT=1
  #   echo "  Detected settings file with version 1.0"
  #   echo "  Updating to version $SETTINGS_VERSION_LATEST"
    sed "s~SETTINGS_VERSION=1.0~SETTINGS_VERSION=$SETTINGS_VERSION_LATEST~" ./settings.conf
  fi

  #Detecting missing settings and add them if necessary
  # General settings
  if [ -z DNS_ENABLED ]
  then
    echo "DNS_ENABLED=0" >> ./settings.conf
  fi
  if [ -z DHCP_ENABLED ]
  then
    echo "DHCP_ENABLED=0" >> ./settings.conf
  fi
  if [ -z FREERADIUS_ENABLED ]
  then
    echo "FREERADIUS_ENABLED=0" >> ./settings.conf
  fi
  if [ -z EJABBERD_ENABLED ]
  then
    echo "EJABBERD_ENABLED=0" >> ./settings.conf
  fi

  if [ -z TIMEZONE ]
  then
    echo "TIMEZONE=Europe/Berlin" >> ./settings.conf
  fi

  if [ -z BUILD_DISABLED_CONTAINERS ]
  then
    echo "BUILD_DISABLED_CONTAINERS=0" >> ./settings.conf
  fi

  # Docker settings
  if [ -z NET_IPv4_SUBNET ]
  then
    echo "NET_IPv4_SUBNET=10.100.0" >> ./settings.conf
  fi
  if [ -z NET_IPv6_PREFIX ]
  then
    echo "NET_IPv6_PREFIX=fd1a:2b17:1d42:cddd:" >> ./settings.conf
  fi
  if [ -z NET_IPv6_NETMASK ]
  then
    echo "6NET_IPv6_NETMASK=80" >> ./settings.conf
  fi

  # DNS settings
  if [ -z DNS_LISTENING_ADDRESS ]
  then
    echo "DNS_LISTENING_ADDRESS=" >> ./settings.conf
  fi
  if [ -z DNS_LISTENING_PORT ]
  then
    echo "DNS_LISTENING_PORT=53" >> ./settings.conf
  fi
  if [ -z DNS_BRIDGE_HOST ]
  then
    echo "DNS_BRIDGE_HOST=2" >> ./settings.conf
  fi

  # DHCP settings
  if [ -z DHCP_LISTENING_ADDRESS ]
  then
    echo "DHCP_LISTENING_ADDRESS=" >> ./settings.conf
  fi
  if [ -z DHCP_LISTENING_PORT ]
  then
    echo "DHCP_LISTENING_PORT=67" >> ./settings.conf
  fi
  if [ -z DHCP_BRIDGE_HOST ]
  then
    echo "DHCP_BRIDGE_HOST=3" >> ./settings.conf
  fi

  # FREERADIUS settings
  if [ -z FREERADIUS_LISTENING_ADDRESS ]
  then
    echo "FREERADIUS_LISTENING_ADDRESS=" >> ./settings.conf
  fi
  if [ -z FREERADIUS_LISTENING_PORT ]
  then
    echo "FREERADIUS_LISTENING_PORT=1812" >> ./settings.conf
  fi
  if [ -z FREERADIUS_BRIDGE_HOST ]
  then
    echo "FREERADIUS_BRIDGE_HOST=4" >> ./settings.conf
  fi

  # EJABBERD settings
  if [ -z EJABBERD_LISTENING_ADDRESS ]
  then
    echo "EJABBERD_LISTENING_ADDRESS=" >> ./settings.conf
  fi
  if [ -z EJABBERD_LISTENING_PORT_1 ]
  then
    echo "EJABBERD_LISTENING_PORT_1=5222" >> ./settings.conf
  fi
  if [ -z EJABBERD_LISTENING_PORT_2 ]
  then
    echo "EJABBERD_LISTENING_PORT_2=5223" >> ./settings.conf
  fi
  if [ -z EJABBERD_LISTENING_PORT_3 ]
  then
    echo "EJABBERD_LISTENING_PORT_3=5269" >> ./settings.conf
  fi
  if [ -z EJABBERD_BRIDGE_HOST ]
  then
    echo "EJABBERD_BRIDGE_HOST=5" >> ./settings.conf
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
