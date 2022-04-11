#!/bin/bash

# follow DigitalOcean
#define database
DBHOST=localhost
DBNAME='dbsosmed'
DBUSER='devopscilsy'
DBPASSWD='1234567890'



#install-mysql-server
sudo apt-get install mysql-server -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

#mysql -u root -e "create user '$DBUSER'@'localhost' identified by '$DBPASSWD'"
#Create Database
mysql -u root -e "CREATE DATABASE $DBNAME"
mysql -u root -e "grant all privileges on $DBNAME.* to 
'$DBUSER'@'%' identified by '$DBPASSWD'"

#allow remote sql from 0.0.0.0
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart

#install-package
sudo apt install apache2 -y
sudo ufw allow in "Apache"
sudo apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php php-mysql unzip -y

# copy wordpress
rm /var/www/html/index.html
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
sudo cp -a /tmp/wordpress/. /var/www/html

# config user permission
# use www-data to run
# in production enviroment, you should give this user minum permission
sudo chown -R www-data:www-data /var/www/html
cd /var/www/html/
touch .htaccess
curl -s [https://api.wordpress.org/secret-key/1.1/salt/
#sed /** grep define **


# set the setgid bit on every directory in our WordPress installation
sudo find /var/www/html/ -type d -exec chmod g+s {} \;

# we'll give group write access to the wp-content directory so that the web interface can make theme and plugin changes
sudo chmod g+w /var/www/html/wp-content;
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chmod -R g+w /var/www/html/wp-content/plugins

# config wordpress database info
sudo sed -i "s/database_name_here/$DBNAME/1" /var/www/html/wp-config.php
sudo sed -i "s/password_here/$DBPASSWD/1" /var/www/html/wp-config.php
sudo sed -i "s/username_here/$DBUSER/1" /var/www/html/wp-config.php
rm -rf /tmp/wordpress

cd /var/www/html/
sudo mysql -u root $DBNAME < dump.sql
sudo service apache2 restart