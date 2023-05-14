COMPOSE_YML=./srcs/docker-compose.yml
WORDPRESS_SRCS=/home/chchin/data/wordpress
MARIADB_SRCS=/home/chchin/data/mysql

all:
	@sudo mkdir -p ${WORDPRESS_SRCS} ${MARIADB_SRCS}
	@docker-compose -f ${COMPOSE_YML} up --build -d

down:
	@docker-compose -f ${COMPOSE_YML} down

clean: down
	@docker system prune -a
	@docker volume rm db wp
	@echo "Docker service has been reset"

fclean: clean
	@sudo rm -rf $(WORDPRESS_SRCS) ${MARIADB_SRCS}
	@echo "Docker storage has been reset"

info:
	@docker-compose -f ${COMPOSE_YML} ps

re: fclean all

.PHONY: all re down clean fclean info