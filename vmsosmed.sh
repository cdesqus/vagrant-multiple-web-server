#!/usr/bin/env bash

DBHOST=localhost
DBNAME='dbsosmed'
DBUSER='devopscilsy'
DBPASSWD='1234567890'

apt-get update -y
apt-get install apache2 php php-mysql -y
rm /var/www/html/index.html && cp -RT /vagrant/sosial-media-master /var/www/html/
apt-get install mysql-server -y

debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

#mysql -u root -e "create user '$DBUSER'@'localhost' identified by '$DBPASSWD'"
mysql -u root -e "CREATE DATABASE $DBNAME"
mysql -u root -e "grant all privileges on $DBNAME.* to 
'$DBUSER'@'%' identified by '$DBPASSWD'"


sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart


cd /var/www/html/
sudo mysql -u root $DBNAME < dump.sql
sudo service apache2 restart