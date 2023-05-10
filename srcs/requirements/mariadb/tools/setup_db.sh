#!/bin/sh

if [ -d /var/lib/mysql/$MYSQL_DATABASE ]; then
	echo "$MYSQL_DATABASE exists"
else
	echo "USE mysql;" > script.sql
	echo "DELETE FROM mysql.user WHERE User='';" >> script.sql
	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost');" >> script.sql
	echo "FLUSH PRIVILEGES;" >> script.sql

	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> script.sql
	echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" >> script.sql
	echo "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> script.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> script.sql
	echo "FLUSH PRIVILEGES;" >> script.sql

	echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> script.sql
	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> script.sql
	echo "FLUSH PRIVILEGES;" >> script.sql

	mysql_install_db --user=mysql
	mysqld --user=mysql --bootstrap < script.sql
fi

exec "$@"