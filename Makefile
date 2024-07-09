DOCKER_COMPOSE = srcs/docker-compose.yml
PROJECT_NAME = maxb_inception
DATA_DIR = ${HOME}/datas

all: build up

build:
	mkdir -p $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) build

#specifying the nginx wordpress and mariadb to up them but not inception as it's a base image
up:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) up --build nginx wordpress mariadb

down:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) down

clean:
	@docker stop $(shell docker ps -qa) || true
	@docker rm $(shell docker ps -qa) || true
	@docker rmi -f $(shell docker images -qa) || true
	@docker volume rm $(shell docker volume ls -q) || true
	@docker network rm $(shell docker network ls -q) 2>/dev/null || true
	@docker system prune -f || true
	@docker volume prune -f || true
	@docker network prune -f || true

nginx:
	docker exec -it nginx bash

wp:
	docker exec -it wordpress bash
	
maria:
	docker exec -it mariadb bash
	
delete:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) down --volumes --remove-orphans

rmf: delete clean

.PHONY: all build up down clean fclean delete rmf
