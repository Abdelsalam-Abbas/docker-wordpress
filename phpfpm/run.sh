#!/bin/bash

# Script to edit the wp-config.php with the database info
# and run nginx and php5-fpm service
WORDPRESS_DIR='/var/www/app'
WORDPRESS_DB=$DB_ENV_WPDB
WORDPRESS_USER=$DB_ENV_WPUSER
WORDPRESS_PASS=$DB_ENV_WPPASS
WORDPRESS_HOST=$DB_PORT_3306_TCP_ADDR
if [ -z $WORDPRESS_HOST ] ## in case of using docker compose which will not import environment variables
then
	echo "getting ip of mysql contianer"
	while  [[ ! $(ping -c 1  mysql) ]] 
	do 
		echo "mysql server is not up yet. waiting..."
	        sleep 1
	done
	WORDPRESS_HOST=$(getent hosts mysql | awk '{ print $1}') 
	echo "Database ip add is $WORDPRESS_HOST"
fi

echo 'Check for the wp-config.php'
#else
while [ ! -f $WORDPRESS_DIR/wp-config-sample.php ] # waiting for downloader container to download files 
do
	echo "waiting for wordpress files to be downloaded"
	sleep 2   
done

echo 'Editing wp-config.php...'
echo 'Starting the service'
cp $WORDPRESS_DIR/wp-config-sample.php $WORDPRESS_DIR/wp-config.php
sed -i "s/database_name_here/$WORDPRESS_DB/" /var/www/app/wp-config.php
sed -i "s/username_here/$WORDPRESS_USER/" /var/www/app/wp-config.php
sed -i "s/password_here/$WORDPRESS_PASS/" /var/www/app/wp-config.php
sed -i "s/localhost/$WORDPRESS_HOST/" /var/www/app/wp-config.php
#fi
sleep 5

#starting php-fpm in foreground

/usr/sbin/php5-fpm -F
