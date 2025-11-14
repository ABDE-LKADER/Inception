DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

all: up

up:
	sudo mkdir -p /home/${USER}/data/mariadb
	sudo mkdir -p /home/${USER}/data/portainer
	sudo mkdir -p /home/${USER}/data/wordpress
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

build:
	docker compose -f $(DOCKER_COMPOSE_FILE) up --build -d

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

restart:
	docker compose -f $(DOCKER_COMPOSE_FILE) restart

logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs

clean:
	docker compose -f $(DOCKER_COMPOSE_FILE) down
	docker system prune -af

fclean: clean
	docker compose -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune --volumes -af
	sudo rm -fr /home/${USER}/data

re: fclean all

.PHONY: up down logs clean