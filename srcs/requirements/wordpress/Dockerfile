FROM debian:buster

RUN apt-get update && \
	apt-get -y install php7.3 php-mysql php-fpm wget sendmail && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 9000

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir -p /var/run/php/

COPY tools/wordpress_setup /usr/local/bin/

RUN chmod +x /usr/local/bin/wordpress_setup.sh

WORKDIR /var/www/html

ENTRYPOINT [ "./tools/wordpress_setup.sh" ]

CMD [ "usr/sbin/php-fpm7.3", "-F" ]