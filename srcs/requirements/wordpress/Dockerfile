FROM debian:buster

RUN apt-get update && \
    apt-get -y install php7.3 php-mysqli php-fpm wget sendmail && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www/

RUN mkdir -p /run/php/

RUN chmod +x /var/www/wordpress_start.sh

ENTRYPOINT [ "/var/www/wordpress_start.sh" ]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]