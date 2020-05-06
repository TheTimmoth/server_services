#!/bin/bash

# Configuration loading and updating script
# Version 1.1

configure() {
  if [ ! -f settings.conf ]; then
    printf "\n# General settings\n" > settings.conf
    echo "DNS_ENABLED=1" >> settings.conf
    echo "DHCP_ENABLED=1" >> settings.conf
    echo "FREERADIUS_ENABLED=1" >> settings.conf
    printf "\n# Docker settings\n" >> settings.conf
    echo "BRIDGE_NET=\"10.201.0\"" >> settings.conf
    printf "\n# DNS settings\n" >> settings.conf
    echo "DNS_LISTENING_ADDRESS=\"10.0.1.1\"" >> settings.conf
    echo "DNS_LISTENING_PORT=53" >> settings.conf
    echo "DNS_BRIDGE_HOST=2" >> settings.conf
    printf "\n# DHCP settings\n" >> settings.conf
    echo "DHCP_LISTENING_ADDRESS=\"10.0.1.1\"" >> settings.conf
    echo "DHCP_LISTENING_PORT=8067" >> settings.conf
    echo "DHCP_BRIDGE_HOST=3" >> settings.conf
    printf "\n# FREERADIUS settings\n"
    echo "FREERADIUS_LISTENING_ADDRESS=\"10.0.1.1\""
    echo "FREERADIUS_LISTENING_PORT=1812"
    echo "FREERADIUS_BRIDGE_HOST=4"
  fi
  source settings.conf
}

updateDockerCompose() {
  # printf "\tLoading configuration...\n"
  # configure
  # printf "\tUpdating file...\n"
  cp templates/docker-compose.yml ./docker-compose.yml
  sed -i "s/%%DNS_ENABLED%%/${DNS_ENABLED}/g" ./docker-compose.yml
  sed -i "s/%%DHCP_ENABLED%%/${DHCP_ENABLED}/g" ./docker-compose.yml
  sed -i "s/%%FREERADIUS_ENABLED%%/${FREERADIUS_ENABLED}/g" ./docker-compose.yml
  sed -i "s/%%BRIDGE_NET%%/${BRIDGE_NET}/g" ./docker-compose.yml
  sed -i "s/%%DNS_LISTENING_ADDRESS%%/${DNS_LISTENING_ADDRESS}/g" ./docker-compose.yml
  sed -i "s/%%DNS_LISTENING_PORT%%/${DNS_LISTENING_PORT}/g" ./docker-compose.yml
  sed -i "s/%%DNS_BRIDGE_HOST%%/${DNS_BRIDGE_HOST}/g" ./docker-compose.yml
  sed -i "s/%%DHCP_LISTENING_ADDRESS%%/${DHCP_LISTENING_ADDRESS}/g" ./docker-compose.yml
  sed -i "s/%%DHCP_LISTENING_PORT%%/${DHCP_LISTENING_PORT}/g" ./docker-compose.yml
  sed -i "s/%%DHCP_BRIDGE_HOST%%/${DHCP_BRIDGE_HOST}/g" ./docker-compose.yml
  sed -i "s/%%FREERADIUS_LISTENING_ADDRESS%%/${FREERADIUS_LISTENING_ADDRESS}/g" ./docker-compose.yml
  sed -i "s/%%FREERADIUS_LISTENING_PORT%%/${FREERADIUS_LISTENING_PORT}/g" ./docker-compose.yml
  sed -i "s/%%FREERADIUS_BRIDGE_HOST%%/${FREERADIUS_BRIDGE_HOST}/g" ./docker-compose.yml
}