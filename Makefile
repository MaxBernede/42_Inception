DOCKER_COMPOSE = srcs/docker-compose.yml
MARIADB_NAME = mariadb

all : build up

build:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) build

up:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) down

delete:
	docker-compose -f $(DOCKER_COMPOSE) -p $(MARIADB_NAME) down --volumes --remove-orphans

.PHONY: all build up down delete