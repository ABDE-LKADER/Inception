DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

all: up

up:
	mkdir -p /home/${USER}/data/mariadb
	mkdir -p /home/${USER}/data/wordpress
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

clean:
	docker system prune --volumes -af

fclean: down clean
	sudo rm -fr /home/${USER}/data

logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs

re: down fclean up

.PHONY: up down clean