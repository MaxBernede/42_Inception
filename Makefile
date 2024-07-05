DOCKER_COMPOSE = srcs/docker-compose.yml
PROJECT_NAME = maxb_inception
DOCKER_PERMISSIONS_DIR = /Users/maxb/.docker
DATA_DIR = ${HOME}/data
#below is only used when i have bad internet and want to store information to not download
IMAGE_STORE_DIR = ${HOME}/temp-docker

all: build up

#sudo chmod -R 777 $(DOCKER_PERMISSIONS_DIR)
build:
	mkdir -p $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	@if [ -f $(IMAGE_STORE_DIR)/debian_bullseye.tar ]; then \
		docker load -i $(IMAGE_STORE_DIR)/debian_bullseye.tar; \
	fi
	@if [ -f "$(IMAGE_STORE_DIR)/files/wordpress-6.0-fr_FR.tar.gz" ]; then \
    	cp "$(IMAGE_STORE_DIR)/files/wordpress-6.0-fr_FR.tar.gz" /Users/maxb/Desktop/inception/new/srcs/requirements/wordpress ;\
	fi
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
	rm ./srcs/requirements/wordpress/wordpress-6.0-fr_FR.tar.gz
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
