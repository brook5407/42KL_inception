COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=/home/chchin/data/wordpress
MARIADB_SRCS=/home/chchin/data/wordpressdb
VOLUME_COUNT=$(shell sudo docker volume ls -q | wc -l;)

all:
	sudo mkdir -p ${WORDPRESS_SRCS}
	sudo mkdir -p ${MARIADB_SRCS}
	docker-compose -f ${COMPOSE_YML} up

clean:
	docker-compose -f ${COMPOSE_YML} down

fclean: clean
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	sudo rm -rf $(WORDPRESS_SRCS);\
	sudo rm -rf ${MARIADB_SRCS}

re: fclean all

.PHONY: all re down clean