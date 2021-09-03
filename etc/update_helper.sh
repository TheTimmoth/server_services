update() {
  shutdown_services

  echo "Recreate \"docker-compose.yml\"..."
  ./setup.sh

  echo "Rebuild and start containers..."
  docker-compose up --build --detach
  echo "Update finished..."
}

shutdown_services() {
  echo "Stop and remove containers..."
  docker-compose down --remove-orphans --rmi all
}
