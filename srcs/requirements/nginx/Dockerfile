FROM  debian:buster

RUN apt-get update && \
    apt-get install -y \
    nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/global.conf /etc/nginx/conf.d
COPY ./tools/create_ssl.sh ./var/www/

RUN chmod +x /var/www/create_ssl.sh

ENTRYPOINT [ "var/www/create_ssl.sh" ]

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]