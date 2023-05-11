#!/bin/bash

touch /run/php/php7.3-fpm.pid;

if [ -d /var/www/html/wp-config.php ]; then
	echo "Wordpress: wp-config.php exists"
else
	echo "Wordpress: setting up..."
	mkdir -p /var/www/html
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html;
	wp core download --allow-root;
	
	sed -i "s/database_name_here/$MYSQL_DATABASE/" ./wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/" ./wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/" ./wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/" ./wp-config-sample.php
	cp wp-config-sample.php wp-config.php
	chown -R www-data:www-data wp-config.php

	echo "Wordpress: Setup wordpress..."
	wp core install --allow-root --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
	wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --display_name=$WP_USER --role=$WP_USER_ROLE --allow-root

	echo "Wordpress: Set up successful!"
fi

exec "$@"