#!/bin/bash

# Configuration loading and updating script
# Version 1.1

configure() {
  if [ ! -f settings.conf ]; then
    printf "No settings file detectes. Creating new one...\n"
    printf "Gathering required information:\n"
    read -p "Please enter the IP Address on which the servers should listen: " IP_ADDRESS
    printf "#########################################################\n" > settings.conf
    printf "# server_services configuration file\n" >> settings.conf
    printf "#########################################################\n" >> settings.conf
    printf "\n# General settings\n" >> settings.conf
    echo "DNS_ENABLED=1" >> settings.conf
    echo "DHCP_ENABLED=1" >> settings.conf
    echo "FREERADIUS_ENABLED=1" >> settings.conf
    printf "\n# Docker settings\n" >> settings.conf
    echo "NET_IPv4_SUBNET=\"10.201.0\"" >> settings.conf
    echo "NET_IPv6_SUBNET=\"fd00::/80\"" >> settings.conf
    printf "\n# DNS settings\n" >> settings.conf
    echo "DNS_LISTENING_ADDRESS=\"$IP_ADDRESS\"" >> settings.conf
    echo "DNS_LISTENING_PORT=53" >> settings.conf
    echo "DNS_BRIDGE_HOST=2" >> settings.conf
    printf "\n# DHCP settings\n" >> settings.conf
    echo "DHCP_LISTENING_ADDRESS=\"$IP_ADDRESS\"" >> settings.conf
    echo "DHCP_LISTENING_PORT=67" >> settings.conf
    echo "DHCP_BRIDGE_HOST=3" >> settings.conf
    printf "\n# FREERADIUS settings\n" >> settings.conf
    echo "FREERADIUS_LISTENING_ADDRESS=\"$IP_ADDRESS\"" >> settings.conf
    echo "FREERADIUS_LISTENING_PORT=1812" >> settings.conf
    echo "FREERADIUS_BRIDGE_HOST=4" >> settings.conf
  fi
  source settings.conf
}

updateDockerCompose() {
  # printf "\tLoading configuration...\n"
  configure
  # printf "\tUpdating file...\n"
  cp templates/docker-compose.yml ./docker-compose.yml
  sed -i "s/%%DNS_ENABLED%%/${DNS_ENABLED}/g" ./docker-compose.yml
  sed -i "s/%%DHCP_ENABLED%%/${DHCP_ENABLED}/g" ./docker-compose.yml
  sed -i "s/%%FREERADIUS_ENABLED%%/${FREERADIUS_ENABLED}/g" ./docker-compose.yml
  sed -i "s/%%NET_IPv4_SUBNET%%/${NET_IPv4_SUBNET}/g" ./docker-compose.yml
  sed -i "s/%%NET_IPv6_SUBNET%%/${NET_IPv6_SUBNET}/g" ./docker-compose.yml
  sed -i "s/%%NET_IPv6_SUFFIX%%/${NET_IPv6_SUFFIX}/g" ./docker-compose.yml
  if [ !  -z  $DNS_LISTENING_ADDRESS ]; then
    echo "1a $DNS_LISTENING_ADDRESS"
    sed -i "s/%%DNS_LISTENING_ADDRESS%%/${DNS_LISTENING_ADDRESS}:/g" ./docker-compose.yml
    sed -i "s/%%DNS_LISTENING_PORT%%/${DNS_LISTENING_PORT}/g" ./docker-compose.yml
  else
    echo "1b $DNS_LISTENING_ADDRESS"
    sed -i "s/%%DNS_LISTENING_ADDRESS%%/${DNS_LISTENING_ADDRESS}/g" ./docker-compose.yml
    sed -i "s/%%DNS_LISTENING_PORT%%/${DNS_LISTENING_PORT}/g" ./docker-compose.yml
  fi
  sed -i "s/%%DNS_BRIDGE_HOST%%/${DNS_BRIDGE_HOST}/g" ./docker-compose.yml
  if [ !  -z  $DHCP_LISTENING_ADDRESS ]; then
    sed -i "s/%%DHCP_LISTENING_ADDRESS%%/${DHCP_LISTENING_ADDRESS}:/g" ./docker-compose.yml
    sed -i "s/%%DHCP_LISTENING_PORT%%/${DHCP_LISTENING_PORT}/g" ./docker-compose.yml
  else
    sed -i "s/%%DHCP_LISTENING_ADDRESS%%/${DHCP_LISTENING_ADDRESS}/g" ./docker-compose.yml
    sed -i "s/%%DHCP_LISTENING_PORT%%/${DHCP_LISTENING_PORT}/g" ./docker-compose.yml
  fi
  sed -i "s/%%DHCP_BRIDGE_HOST%%/${DHCP_BRIDGE_HOST}/g" ./docker-compose.yml
  if [ !  -z  $FREERADIUS_LISTENING_ADDRESS ]; then
    sed -i "s/%%FREERADIUS_LISTENING_ADDRESS%%/${FREERADIUS_LISTENING_ADDRESS}:/g" ./docker-compose.yml
    sed -i "s/%%FREERADIUS_LISTENING_PORT%%/${FREERADIUS_LISTENING_PORT}/g" ./docker-compose.yml
  else
    sed -i "s/%%FREERADIUS_LISTENING_ADDRESS%%/${FREERADIUS_LISTENING_ADDRESS}/g" ./docker-compose.yml
    sed -i "s/%%FREERADIUS_LISTENING_PORT%%/${FREERADIUS_LISTENING_PORT}/g" ./docker-compose.yml
  fi
  sed -i "s/%%FREERADIUS_BRIDGE_HOST%%/${FREERADIUS_BRIDGE_HOST}/g" ./docker-compose.yml
}