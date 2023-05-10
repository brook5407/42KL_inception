FROM debian:buster

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/setup_mysql.sh /var/www/

RUN chmod +x /var/www/setup_mysql.sh

ENTRYPOINT [ "bash", "/var/www/setup_mysql.sh" ]

CMD ["mysqld_safe"]