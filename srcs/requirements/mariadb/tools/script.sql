CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'chchin'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'chchin'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';