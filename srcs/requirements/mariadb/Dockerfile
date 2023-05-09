FROM debian:buster

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools /var/www/

ENTRYPOINT [ "/var/www/setup_mysql.sh" ]

EXPOSE 3306

CMD ["mysqld"]