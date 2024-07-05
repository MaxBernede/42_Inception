# !/bin/bash

# Wait for MariaDB to be ready
#TAKE CARE IN CASE DELAY TOO SHORT, NEW PROBLEM
sleep 6

# wp-cli installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# wp-cli permission
chmod +x wp-cli.phar
# wp-cli move to bin
mv wp-cli.phar /usr/local/bin/wp

# give permission to wordpress directory
echo "ECHO BEFORE FIRST CHMOD"
chmod -R 755 /var/www/wordpress/
echo "BETWEEN"
chmod 777 /var/www/wordpress/wp-config.php

# Check if wp-config.php does not exist and create it
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    #Create the wp-config.php file using WP-CLI
    # echo -e "Run config create"
    # wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
    #                  --dbhost=mariadb:3306 --path='/var/www/wordpress' #--debug
    # # Wait for the config creation to complete
    # sleep 2
    # echo -e "Run core install"
    # # Install WordPress core
    # wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress' #--debug
    # # Create an additional user
    # wp user create --allow-root --role=author $ALL_USER $ALL_EMAIL --user_pass=$ALL_PASSWORD --path='/var/www/wordpress' >> /var/log/wp-user-create.log
    
    #flip test
    #download wordpress core files
    echo "I AM ECHO IN  THE IF STATEMENT"
    wp core download --allow-root
    # create wp-config.php file with database details
    wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
    # install wordpress with the given title, admin username, password and email
    wp core install --url="$DOMAIN_NAME" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root
    #create a new user with the given username, email, password and role
    wp user create "$ALL_USER" "$ALL_EMAIL" --user_pass="$ALL_PASSWORD" --role=author --path="/var/www/wordpress" --allow-root

fi

# If /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi


# Start PHP-FPM
/usr/sbin/php-fpm7.4 -F
