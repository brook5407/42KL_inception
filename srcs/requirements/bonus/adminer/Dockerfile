FROM debian:buster

RUN apt-get update && \
    apt-get install wget nginx php7.3 php-fpm php-mysql -y

COPY conf/nginx.conf /conf/

COPY tools/setup.sh /usr/local/bin

RUN chmod +x /usr/local/bin/setup.sh

RUN mkdir -p /run/php/

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["nginx", "-c", "/conf/nginx.conf"]