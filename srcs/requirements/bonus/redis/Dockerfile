FROM debian:buster

RUN apt-get -y update && \
    apt install redis-server -y && \
    rm -rf /var/lib/apt/lists/*
    
expose 6379

RUN sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
RUN sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
RUN sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

CMD ["redis-server",  "--protected-mode", "no"]