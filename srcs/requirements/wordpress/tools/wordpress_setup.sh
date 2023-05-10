#!/bin/bash

if [ -d /var/www/html/wordpress ]; then
	echo "Wordpress: setting up..."
	wget https://wordpress.org/latest.tar.gz
	tar -xvf latest.tar.gz
	mv wordpress/* .
	rm -rf wordpress latest.tar.gz

	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	wp core install --allow-root --url=$DOMAIN_NAME --title="Inception" --admin_name=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
	wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --display_name=$WP_USER --role=$WP_USER_ROLE --allow-root

	echo "Wordpress: set up!"
fi

exec "$@"