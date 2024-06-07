#!/bin/bash

# Function to delete Docker images if they exist
delete_images() {
  if [ -z "$(docker images -q)" ]; then
    echo "No images to delete."
  else
    docker rmi $(docker images -q)
  fi
}

# Function to stop and remove containers, networks, volumes, and orphans defined in the Docker Compose file
delete_containers() {
  docker-compose -f "$DOCKER_COMPOSE" -p "$PROJECT_NAME" down --volumes --remove-orphans
}

# Function to remove all Docker volumes if they exist
delete_volumes() {
  if [ -z "$(docker volume ls -q)" ]; then
    echo "No volumes to delete."
  else
    docker volume rm $(docker volume ls -q)
  fi
}

# Function to remove all Docker networks if they exist
delete_networks() {
  if [ -z "$(docker network ls -q | grep -v 'bridge\|host\|none')" ]; then
    echo "No networks to delete."
  else
    docker network rm $(docker network ls -q | grep -v 'bridge\|host\|none')
  fi
}

# Main function to perform the full cleanup
main() {
  delete_containers
  delete_images
  delete_volumes
  delete_networks
  rm -rf ./srcs/web
  rm -rf ./srcs/database
}

# Set environment variables for Docker Compose file and project name
DOCKER_COMPOSE="docker-compose.yml"
PROJECT_NAME="my_project"

# Execute the main function
main
