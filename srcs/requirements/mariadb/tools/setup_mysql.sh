service mysql start

if test -f /var/lib/mysql/$MYSQL_DATABASE;
then
	echo "$MYSQL_DATABASE exist"
else
    echo "CREATE DATABASE $MYSQL_DATABASE;" > script.sql
    echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> script.sql
    echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
    echo "FLUSH PRIVILEGES;" >> script.sql
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> script.sql
    echo "$MYSQL_DATABASE created"
fi

mysql < script.sql && rm -rf script.sql