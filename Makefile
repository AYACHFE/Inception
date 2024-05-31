all:
	docker compose -f srcs/docker-compose.yml up -d --build
build:
	sudo rm -rf /home/ayac/data/mariadb/*
	sudo rm -rf /home/ayac/data/wordpress/*
	docker compose -f srcs/docker-compose.yml down
	docker compose -f srcs/docker-compose.yml up --build

clean:
	@echo "\033[0;32m--------------Containers are DOWN--------------\033[0m"
	docker compose -f srcs/docker-compose.yml down
	
fclean: clean
	@echo "\033[0;32m--------------Started Deep Cleaning--------------\033[0m"
	docker system prune -af
	sudo rm -rf /home/ayac/data/mariadb/*
	sudo rm -rf /home/ayac/data/wordpress/*
	@echo "\033[0;32m--------------Done Cleaning--------------\033[0m"

re: fclean all

run: fclean build