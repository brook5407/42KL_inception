FROM debian:buster

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/setup_mysql.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup_mysql.sh

ENTRYPOINT [ "/usr/local/bin/setup_mysql.sh" ]

CMD ["mysqld_safe"]