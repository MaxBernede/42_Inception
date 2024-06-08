DOCKER_COMPOSE = srcs/docker-compose.yml
PROJECT_NAME = maxb_inception

all : build up


build:
	sudo chmod -R 777 /Users/maxb/.docker
	mkdir -p ${HOME}/data
	mkdir -p ${HOME}/data/wordpress
	mkdir -p ${HOME}/data/mariadb
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) build


up:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) up --build

down:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) down

#-z check if the value is empty.
#docker images -q, gives all the images ID one per line
delete_images:
	@if [ -z "$$(docker images -q)" ]; then \
		echo "No images to delete."; \
	else \
		docker rmi $$(docker images -q); \
	fi

delete:
	docker-compose -f $(DOCKER_COMPOSE) -p $(PROJECT_NAME) down --volumes --remove-orphans

rmf: delete delete_images

.PHONY: all build up down delete delete_images rmf