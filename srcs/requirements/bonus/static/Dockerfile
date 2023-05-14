FROM debian:buster

RUN apt-get update && apt-get install nginx -y

COPY conf/nginx.conf /conf/
COPY tools/ /var/www/html/

CMD ["nginx", "-c", "/conf/nginx.conf"]