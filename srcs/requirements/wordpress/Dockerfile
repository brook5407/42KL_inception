FROM debian:buster

RUN apt-get update && \
	apt-get -y install php7.3 php-mysqli php-fpm wget && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

COPY ./tools /var/www/

RUN chmod +x /var/www/wordpress_start.sh

ENTRYPOINT [ "/var/www/setup_wordpress.sh" ]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]