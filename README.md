<h1 align="center">
  🐳Inception
</h1>

<p align="center">
	<b><i>This document is a System Administration related exercise</i></b><br>
</p>

<p align="center">
	<img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/brook5407/42KL_inception">
	<img alt="Lines of code" src="https://img.shields.io/tokei/lines/github/brook5407/42KL_inception">
	<img alt="GitHub language count" src="https://img.shields.io/github/languages/count/brook5407/42KL_inception">
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/brook5407/42KL_inception">
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/brook5407/42KL_inception">
</p>

<h3 align="center">
	<a href="#-about">About</a>
	<span> · </span>
  	<a href="#-content">Content</a>
	<span> · </span>
	<a href="#%EF%B8%8F-usage">Usage</a>
	<span> · </span>
	<a href="#-explaination">Explaination</a>

</h3>

## 💡 About

> This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

---

## 🚀 Content

### 🚩 Mandatory part

This project consists in having you set up a small infrastructure composed of different services under specific rules. The whole project has to be done in a virtual machine. You have to use docker compose.

Each Docker image must have the same name as its corresponding service.

Each service has to run in a dedicated container.

For performance matters, the containers must be built either from the penultimate stable version of Alpine or Debian. The choice is yours.

You also have to write your own Dockerfiles, one per service. The Dockerfiles must be called in your docker-compose.yml by your Makefile.

It means you have to build yourself the Docker images of your project. It is then for- bidden to pull ready-made Docker images, as well as using services such as DockerHub (Alpine/Debian being excluded from this rule).

You then have to set up:
- A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
- A Docker container that contains WordPress + php-fpm (it must be installed and configured) only without nginx.
- A Docker container that contains MariaDB only without nginx.
- A volume that contains your WordPress database.
- A second volume that contains your WordPress website files.
- A docker-network that establishes the connection between your containers. Your containers have to restart in case of a crash.

In your WordPress database, there must be two users, one of them being the ad- ministrator. The administrator’s username can’t contain admin/Admin or admin- istrator/Administrator (e.g., admin, administrator, Administrator, admin-123, and so forth).

To make things simpler, you have to configure your domain name so it points to your local IP address.

This domain name must be login.42.fr. Again, you have to use your own login.

For example, if your login is wil, wil.42.fr will redirect to the IP address pointing to wil’s website.

### ⭐️ Bonus

For this project, the bonus part is aimed to be simple.
A Dockerfile must be written for each extra service. Thus, each one of them will run inside its own container and will have, if necessary, its dedicated volume.

Bonus list:
- Set up redis cache for your WordPress website in order to properly manage the cache.
- Set up a FTP server container pointing to the volume of your WordPress website.
- Create a simple static website in the language of your choice except PHP (Yes, PHP is excluded!). For example, a showcase site or a site for presenting your resume.
- Set up Adminer.
- Set up a service of your choice that you think is useful. During the defense, you will have to justify your choice.

---

## 💡 Explaination

### Docker
- Allows developers to package their application and their dependencies into lightweight containers that can be run on any machine.
- Docker containers are isolated environment that can run application without the need of an dedicated operating system.

### Docker-compose
- Allows you to define and run multi-container Docker applications.
- Define network, specify dependencies, storage requirements and more.

### Docker image with docker-compose and without
- Docker image built without docker-compose is used to run a single container instance.
- Docker image built with docker-compose usually used to run an application stack where consists of multiple different services.

### Docker vs VMs
- Docker is lightweight and highly portable, scalability, consistency and isolation.

### NGINX
Nginx is a webserver which stores hmtl, js, images files and use http request to display a website. Nginx conf documents will be used to config our server and the right proxy connexion.
- Add `daemon off;` in main block (outside of http, events, server blocks)
- Configure nginx server block:
  - `listen` on port 443
  - `ssl_protocols` TLSv1.2 TLSv1.3
  - configure path for certificate and key for ssl
  - configure `server_name` (eg. domian name)
  - `root` (dir where wordpress is extracted)

### PHP-FPM 
PHP-FPM (for fast-cgi Process Manager) runs as an isolated service when you use PHP-FPM. Employing this PHP version as the language interpreter means requests will be processed via a TCP/IP socket, and the Nginx server handles HTTP requests only, while PHP-FPM interprets the PHP code. Taking advantage of two separate services is vital to become more efficient. It features with Wordpress
- It is used to execute PHP scripts in web server environment like NGINX and Apache.
- Modify nginx.conf server block again with configuring `fastcgi` in `location ~ \.php$` block which is a regular expression that matches any URI that ends with ".php".
- Configure `www.conf` in /etc/php/\<version>/fpm/pool.d to listen on port 9000

### WORDPRESS
WordPress is a content management system (CMS) based on PHP and MySQL. It is an open-source platform that is widely used for building websites, blogs, and applications
- use `wget` to download wp-cli to configure the wordpress without web browser
- use `wp config create` to create wp-config.php and configure the wordpress database.
- use `wp core install` to create the wordpress table in the database.
- use `wp user create` to create the additional user login to access wordpress.

### MARIADB
MariaDB is a free and open-source relational database management system (RDBMS) that is widely used as a drop-in replacement for MySQL
- use `echo` to save sql script to script.sql to avoid any secret being expose.
- change the root user to new password
- create a new mysql user and allow remote access `%`
- grant all privileges of the wordpress db to the new user

### REDIS
Remote Dictionary Server (Redis) is an in-memory, persistent, key-value database known as a data structure server. One important factor that differentiates Redis from similar servers is its ability to store and manipulate high-level data types (common examples include lists, maps, sets, and sorted sets).
- Change the value in redis.conf:
  - remove the bind address
  - set the max memory to `2mb`
  - set the `allkeys-lru policy` in max memory policy

### ADMINER
Replace phpMyAdmin with Adminer and you will get a tidier user interface, better support for MySQL features, higher performance and more security.
- use the nginx server to setup adminer service.
- configure the nginx.conf which has done before.
- configure the sock in www.conf to the mariadb port.
  
### FTP
An FTP Server, in the simplest of definitions, is a software application that enables the transfer of files from one computer to another. FTP (which stands for “File Transfer Protocol”) is a way to transfer files to any computer in the world that is connected to the Internet.
- Configure vsftpd.conf:
  - `min port` and `max port` value must be same in the docker composer
  - set the `local_root` value to wordpress volume address.

### CADVISOR (extra setvice)
cAdvisor (Container Advisor) provides container users an understanding of the resource usage and performance characteristics of their running containers. It is a running daemon that collects, aggregates, processes, and exports information about running containers.
