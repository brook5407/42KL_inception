#!/bin/sh
FILE=wordpress
cd /var/www/html

if [ -d "$FILE" ]; then
    echo "$FILE already setup."
else
    wp core download --allow-root 
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root 

    wp core install --url=$DOMAIN_NAME --title="BROOK's INCEPTION" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root  
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=$WP_USER_ROLE --allow-root 
    wp theme install neve --activate --allow-root  
    
    # wp config set WP_REDIS_HOST redis --add --allow-root
    # wp config set WP_REDIS_PORT 6379 --add --allow-root  
    # wp config set WP_CACHE true --add --allow-root  
    # wp plugin install redis-cache --activate --allow-root  
    # wp plugin update --all --allow-root  
    wp redis enable --allow-root  
    echo "$FILE setup successful!" 
fi

/usr/sbin/php-fpm7.3 -F