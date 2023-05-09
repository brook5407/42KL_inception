COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=/home/chchin/data/wordpress
MARIADB_SRCS=/home/chchin/data/mysql
VOLUME_COUNT=$(shell sudo docker volume ls -q | wc -l;)

all:
	@sudo mkdir -p ${WORDPRESS_SRCS} ${MARIADB_SRCS}
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

clean:
	@docker-compose -f ${COMPOSE_YML} down

fclean: clean
	@docker rmi -f $$(docker images -qa)
	@docker volume rm $$(docker volume ls -q)
	@docker network rm $$(docker network ls -q)
	@sudo rm -rf $(WORDPRESS_SRCS) ${MARIADB_SRCS}
	echo "Docker: All clean"

re: fclean all

.PHONY: all re down clean