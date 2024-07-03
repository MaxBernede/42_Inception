# #!bin/bash
# sleep 10
# if [ ! -e /var/www/wordpress/wp-config.php ]; then
#     wp config create	--allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
#     					--dbhost=mariadb:3306 --path='/var/www/wordpress'

# sleep 2
# wp core install     --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
# wp user create      --allow-root --role=author $ALL_USER $ADMIN_EMAIL --user_pass=$ALL_PASSWORD --path='/var/www/wordpress' >> /log.txt
# fi

# # echo "define( 'CONCATENATE_SCRIPTS', false );" >> /var/www/wordpress/wp-config.php
# # echo "define( 'SCRIPT_DEBUG', true );" >> /var/www/wordpress/wp-config.php
# # echo "define( 'WP_HOME', 'https://jcluzet.42.fr' );" >> /var/www/wordpress/wp-config.php
# # echo "define( 'WP_SITEURL', 'https://jcluzet.42.fr' );" >> /var/www/wordpress/wp-config.php

# # echo "define( 'WP_DEBUG', true);" >> /var/www/wordpress/wp-config.php
# # echo "define( 'WP_DEBUG_LOG', true);" >> /var/www/wordpress/wp-config.php
# # echo "define( 'WP_DEBUG_DISPLAY', false);" >> /var/www/wordpress/wp-config.php
# # echo "define('WP_ALLOW_REPAIR', true);" >> /var/www/wordpress/wp-config.php

	

# # if /run/php folder does not exist, create it
# if [ ! -d /run/php ]; then
#     mkdir ./run/php
# fi
# /usr/sbin/php-fpm7.3 -F

# !/bin/bash

# Wait for MariaDB to be ready
sleep 10

# Check if wp-config.php does not exist and create it
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    # Create the wp-config.php file using WP-CLI
    wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD \
                     --dbhost=mariadb:3306 --path='/var/www/wordpress'

    # Wait for the config creation to complete
    sleep 2
    
    # Install WordPress core
    wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
    
    # Create an additional user
    wp user create --allow-root --role=author $ALL_USER $ALL_EMAIL --user_pass=$ALL_PASSWORD --path='/var/www/wordpress' >> /var/log/wp-user-create.log
fi

# If /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

# Start PHP-FPM
/usr/sbin/php-fpm7.3 -F
