#!/bin/bash

# Creating Your CSR with OpenSSL
# https://mariadb.com/docs/xpand/security/data-in-transit-encryption/create-self-signed-certificates-keys-openssl/
# https://www.digicert.com/kb/csr-ssl-installation/nginx-openssl.htm
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -x509 -newkey rsa:2048 -nodes -days 365  \
    -keyout /etc/ssl/chchin.key \
    -out $CERTS_ \
    -subj "/C=MY/ST=Selangor/L=Subang Jaya/O=42/OU=KL/CN=chchin";
echo "Nginx: ssl is set up!";
fi

exec "$@"