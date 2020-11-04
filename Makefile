# import config.
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# HELP
# This will output the help for each task
.PHONY: help

help: ## This help.
	@echo -e "\e[92m$(APP_NAME)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# Make TASKS

run: ## Start all or container services or just s=<ServiceName> in background
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) up -d $(s)

up: run ## Start all or container services or just s=<ServiceName> in background (Alias to run)

build: run ## Start all or container services or just s=<ServiceName> in background (Alias to run)

rebuild: ## Rebuild and start all or container services or just s=<ServiceName> in background
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) up --force-recreate --build -d $(s)

restart: ## Restart all or container services or just s=<ServiceName> in background
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) stop $(s)
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) up $(s) -d

debug: ## Create and start all or just s=<ServiceName> container services in debug [Recreates all containers to makes sure you debug the latest version].
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) up --force-recreate --build $(s)

logs: ## Show logs for all or just s=<ServiceName> container services
	$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) logs --tail=100 -f $(s)

ps: ## Show status of containers
	@$(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_FILE) ps

status: ps ## Show status of containers (Alias to ps)	

stop: ## Stop all or just s=<ServiceName> container services
	$(DOCKER_COMPOSE_COMMAND) stop $(s)

rm: ## Remove all or just s=<ServiceName> container services
	$(DOCKER_COMPOSE_COMMAND) rm $(s)

down: ## Stop and remove all or s=<ServiceName> containers, networks, images, and volumes
	$(DOCKER_COMPOSE_COMMAND) down $(s)

clean: ## Remove all running containers and volumes
	$(DOCKER_COMPOSE_COMMAND) down --volumes --rmi all

cleanall: confirmation ## Remove all running containers, volumes. Also removes all unused images, unused volumes. Use with caution!!
	$(DOCKER_COMPOSE_COMMAND) down --volumes --rmi all
	docker system prune -a -f
	docker volume prune -f

################################## Helpers ##############################
confirmation:
	@( read -p "Are you sure?!? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac ) 