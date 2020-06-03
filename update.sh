#!/bin/bash

# Update script

update() {
  docker-compose down --rmi all
  git pull
  docker-compose up --detach
  read -n 1 -s -r -p "Update finished. Press any key to continue..."
  echo ""
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
