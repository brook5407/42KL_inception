FROM debian:buster

RUN	apt-get update && apt-get install -y vsftpd

COPY conf/vsftpd.conf /var/www/vsftpd.conf

COPY tools/ftp_setup.sh /usr/local/bin/ftp_setup.sh

RUN chmod +x /usr/local/bin/ftp_setup.sh

CMD ["/usr/local/bin/ftp_setup.sh"]