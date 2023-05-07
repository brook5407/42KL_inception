#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress: setting up..."
	mkdir -p /var/www/html
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	cp -r  wordpress/* /var/www/html/ && rm -rf wordpress

	sed -i "23s/.*/define( 'DB_NAME', '$MYSQL_DATABASE' );/g" /var/www/html/wp-config-sample.php
	sed -i "26s/.*/define( 'DB_USER', '$MYSQL_USER' );/g" /var/www/html/wp-config-sample.php
	sed -i "29s/.*/define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );/g" /var/www/html/wp-config-sample.php
	sed -i "32s/.*/define( 'DB_HOST', '$MYSQL_HOSTNAME' );/g" /var/www/html/wp-config-sample.php

	sed -i "82s/.*/define( 'WP_DEBUG', true );/g" /var/www/html/wp-config-sample.php
	sed -i "83s/.*/define( 'WP_DEBUG_LOG', true );/g" /var/www/html/wp-config-sample.php

	cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
	echo "Wordpress: set up!"
fi

exec "$@"