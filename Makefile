DOCKER_COMPOSE = srcs/docker-compose.yml
MARIADB_NAME = mariadb

all : build up

build:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) build

up:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) down

#-z check if the value is empty.
#docker images -q, gives all the images ID one per line
delete_images:
	@if [ -z "$(docker images -q)" ]; then \
		echo "No images to delete."; \
	else \
		docker rmi $(docker images -q); \
	fi

delete:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) down --volumes --remove-orphans

rmf: delete delete_images

.PHONY: all build up down delete delete_images rmf