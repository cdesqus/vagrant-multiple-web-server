#!/usr/bin/env bash

#define database
#DBHOST=localhost
#DBNAME='dbsosmed'
#DBUSER='devopscilsy'
#DBPASSWD='1234567890'

#update package & Install Package
sudo apt-get update -y
sudo apt-get install apache2 php php-mysql -y
sudo apt-get install git -y

# Clone from repository
cd /tmp
git clone https://github.com/cdesqus/landingpage.git

# Copy from git local repo to /var/www/html
sudo rm /var/www/html/index.html
cd landingpage
sudo cp -r ./* /var/www/html/

#install mysql-server
#apt-get install mysql-server -y

#preset answer mysql
#debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
#debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

#mysql -u root -e "create user '$DBUSER'@'localhost' identified by '$DBPASSWD'"
#mysql -u root -e "CREATE DATABASE $DBNAME"
#mysql -u root -e "grant all privileges on $DBNAME.* to 
#'$DBUSER'@'%' identified by '$DBPASSWD'"

#allow remote sql from 0.0.0.0
#sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
#sudo service mysql restart


cd /var/www/html/
#sudo mysql -u root $DBNAME < dump.sql
sudo service apache2 restart