#!/bin/bash

if [ ! -f "/etc/vsftpd.userlist" ]; then

	mkdir -p /var/www/html
	mkdir -p /var/run/vsftpd/empty
	chmod -R 777 /var/www/wordpress

	mv /var/www/vsftpd.conf /etc/vsftpd.conf

	useradd -m -s /bin/bash $FTP_USER
	echo $FTP_USER > /etc/vsftpd.userlist
	echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
	chown -R $FTP_USER:$FTP_USER  /var/www/html
    echo "FTP: setup successful!"
fi

/usr/sbin/vsftpd /etc/vsftpd.conf