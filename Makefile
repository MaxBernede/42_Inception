# Define the default target
all: build-mariadb run-mariadb

# Define targets for building Docker images
build-mariadb:
	docker build -t mariadb_image srcs/requirements/mariadb

# Define targets for running Docker containers
run-mariadb:
	docker run --name mariadb_container -d my-mariadb-image

#clean all not used containers and images
clean-all:
	docker system prune -a

#remove everything by force
kill_all:
	@CONTAINERS=$$(docker container ls -aq); \
	if [ -n "$$CONTAINERS" ]; then \
		docker container stop $$CONTAINERS; \
		docker container rm $$CONTAINERS; \
	else \
		echo "No containers to stop or remove."; \
	fi
	docker system prune -a --force



.PHONY: run-mariadb build-mariadb clean_all all