# !/bin/bash

# Wait for MariaDB to be ready
#TAKE CARE IN CASE DELAY TOO SHORT, NEW PROBLEM
sleep 5

# Check if wp-config.php does not exist and create it
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    # Create the wp-config.php file using WP-CLI
    echo -e "Run config create\n"
    wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
                     --dbhost=mariadb:3306 --path='/var/www/wordpress' #--debug

    # Wait for the config creation to complete
    sleep 2

    echo -e "Run core install\n"
    # Install WordPress core
    wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress' #--debug
    
    # Create an additional user
    wp user create --allow-root --role=author $ALL_USER $ALL_EMAIL --user_pass=$ALL_PASSWORD --path='/var/www/wordpress' >> /var/log/wp-user-create.log
fi

# If /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi


# Start PHP-FPM
/usr/sbin/php-fpm7.4 -F
