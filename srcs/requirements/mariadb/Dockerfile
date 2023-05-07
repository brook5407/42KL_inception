FROM debian:buster

RUN apt-get update && \
    apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN service mysql start && \
    mysql < /var/www/script.sql && \
    rm -f /var/www/script.sql;

CMD ["mysqld"]