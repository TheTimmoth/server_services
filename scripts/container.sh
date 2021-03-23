#!/bin/bash

main() {
  if [[ "$SERVICE" == "DNS" ]]; then
    source /scripts/dns.sh
  elif [[ "$SERVICE" == "DHCP" ]]; then
    source /scripts/dhcp.sh
  elif [[ "$SERVICE" == "FREERADIUS" ]]; then
    source /scripts/freeradius.sh
  elif [[ "$SERVICE" == "EJABBERD" ]]; then
    source /scripts/ejabberd.sh
  else
    source /scripts/sceleton.sh
  fi

  if [[ "$MODE" == "run" ]]; then
    if [[ $ENABLED -eq 1 ]]; then
      source /scripts/timezone.sh
      timezone
      run
    else
      echo "$SERVICE is currently disabled. If you want to enable it, please change ${SERVICE}_ENABLED in settings.conf to \"1\"."
      echo "Entering sleep mode..."
      sleep 365d
    fi
  elif [ "$MODE" == "install" ]; then
    install
  fi
}

MODE=$1
main
