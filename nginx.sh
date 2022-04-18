#! /bin/bash
# Nginx Web Server Installation
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install nginx
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
echo "Ngnix wen server is installed and running"

# MariaDB Installtion
sudo apt-get update
sudo apt-get install mariadb-server-10.1 mariadb-server-core-10.1
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation
sudo systemctl restart mariadb.service
echo "Maria DB is installed and running"

# PHP Installtion
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.2
sudo apt-get install imagemagick php7.2-fpm php7.2-intl php7.2-xml php7.2-curl php7.2-gd php7.2-mbstring php7.2-mysql php7.2-mysql php-apcu php7.2-zip
echo "PHP is installed"