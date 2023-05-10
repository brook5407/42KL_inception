#!/bin/bash

sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;
touch /run/php/php7.3-fpm.pid;

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress: setting up..."
	mkdir -p /var/www/html
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html;
	wp core download --allow-root;
	
	mv /var/www/wp-config.php /var/www/html/
	sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wp-config.php
	sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/" /var/www/html/wp-config.php

	echo "Wordpress: creating users..."
	wp core install --allow-root --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
	wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --display_name=$WP_USER --role=$WP_USER_ROLE --allow-root

	echo "Wordpress: set up!"
fi

exec "$@"