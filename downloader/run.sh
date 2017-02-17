if [ ! -f /var/www/app/latest.tar.gz ] # don't download it if it is already exist 
then
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz --strip-component=1
fi
