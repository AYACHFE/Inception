all:
	docker compose -f srcs/docker-compose.yml up --build
	
clean:
	@echo "\033[0;32m--------------Started Cleaning--------------\033[0m"
	docker compose -f srcs/docker-compose.yml down
	docker volume prune -f
	# docker rmi -f $$(docker images -q)
	rm -rf /Users/gebruiker/Desktop/mariadb/*
	rm -rf /Users/gebruiker/Desktop/wordpress/*
	@echo "\033[0;32m--------------Done Cleaning--------------\033[0m"

run: clean
	docker compose -f srcs/docker-compose.yml up --build