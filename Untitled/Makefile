clean:
	docker compose down
    docker volume prune -f
	docker volume rm $(docker volume ls -q)
    docker rmi -f $$(docker images -q)

run: clean
    docker compose up --build