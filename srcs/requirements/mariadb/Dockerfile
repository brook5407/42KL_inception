FROM debian:buster

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/setup_db.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup_db.sh

ENTRYPOINT [ "/usr/local/bin/setup_db.sh" ]

CMD ["mysqld_safe"]