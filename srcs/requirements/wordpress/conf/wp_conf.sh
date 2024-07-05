#!/bin/bash

#---------------------------------------------------wp installation---------------------------------------------------#
# wp-cli installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# wp-cli permission
chmod +x wp-cli.phar
# wp-cli move to bin
mv wp-cli.phar /usr/local/bin/wp

# go to wordpress directory
cd /var/www/html
# give permission to wordpress directory
sudo chmod -R 755 /var/www/html/
sudo chmod 777 /var/www/html/wp-config.php

# change owner of wordpress directory to www-data
chown -R www-data:www-data /var/www/html
#---------------------------------------------------ping mariadb---------------------------------------------------#
# check if mariadb container is up and running
ping_mariadb_container() {
    nc -zv mariadb 3306 > /dev/null # ping the mariadb container
    return $? # return the exit status of the ping command
}
start_time=$(date +%s) # get the current time in seconds
end_time=$((start_time + 20)) # set the end time to 20 seconds after the start time
while [ $(date +%s) -lt $end_time ]; do # loop until the current time is greater than the end time
    ping_mariadb_container # Ping the MariaDB container
    if [ $? -eq 0 ]; then # Check if the ping was successful
        echo "[========MARIADB IS UP AND RUNNING========]"
        break # Exit the loop if MariaDB is up
    else
        echo "[========WAITING FOR MARIADB TO START...========]"
        sleep 1 # Wait for 1 second before trying again
    fi
done

if [ $(date +%s) -ge $end_time ]; then # check if the current time is greater than or equal to the end time
    echo "[========MARIADB IS NOT RESPONDING========]"
fi
#---------------------------------------------------wp installation---------------------------------------------------##---------------------------------------------------wp installation---------------------------------------------------#

echo "I AM ECHO IN  THE IF STATEMENT"
wp core download --allow-root --path="/var/www/html"
# create wp-config.php file with database details
wp core config --path="/var/www/html" --dbhost=mariadb:3306 --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
# install wordpress with the given title, admin username, password and email
wp core install --path="/var/www/html" --url="$DOMAIN_NAME" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root
#create a new user with the given username, email, password and role
wp user create "$ALL_USER" "$ALL_EMAIL" --user_pass="$ALL_PASSWORD" --role=author --path="/var/www/html" --allow-root

#---------------------------------------------------php config---------------------------------------------------#

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# create a directory for php-fpm
mkdir -p /run/php
# start php-fpm service in the foreground to keep the container running
/usr/sbin/php-fpm7.4 -F
