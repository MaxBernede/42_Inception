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
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) down
	docker system prune -f --volumes

fclean: clean
	@if [ -n "$$(docker images -q)" ]; then \
		docker rmi $$(docker images -q); \
	else \
		echo "No images to delete."; \
	fi
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	else \
		echo "No volumes to delete."; \
	fi
	@if [ -n "$$(docker network ls -q)" ]; then \
		docker network rm $$(docker network ls -q); \
	else \
		echo "No networks to delete."; \
	fi

delete:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) down --volumes --remove-orphans

rmf: delete fclean

.PHONY: all build up down clean fclean delete rmf
