#!/bin/bash

# Update script

update() {
  echo "Stop and remove containers..."
  docker-compose down --rmi all

  echo "Pulling newest version..."
  git pull

  echo "Recreate \"docker-compose.yml\"..."
  ./setup.sh no_edit

  echo "Rebuild and start containers..."
  docker-compose up --build --detach
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
