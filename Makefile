DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

all: up

up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

clean:
	docker system prune --volumes -af

fclean: clean
	rm -fr /Users/${USER}/data/mariadb

logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs

re: down fclean up

.PHONY: up down clean
