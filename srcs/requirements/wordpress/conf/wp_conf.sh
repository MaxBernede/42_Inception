#!/bin/bash

# wp-cli installation here is the same as wget from the dockerfile
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar                        # wp-cli permission
mv wp-cli.phar /usr/local/bin/wp            # wp-cli move to bin


cd /var/www/html                            # Fix the random error someone told me about
sudo chmod -R 755 /var/www/html/
sudo chmod 777 /var/www/html/wp-config.php  # Only works if config is created so not the first run
chown -R www-data:www-data /var/www/html    # change owner of wordpress directory to www-data


# Waiting for Mariadb to start
source /wait_container.sh                   # source the function to use it
wait_for_mariadb                            # wait start


# Wordpress
WP_PATH="/var/www/html"
ls "$WP_PATH"                               # check existence of the path

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "[========DOWNLOADING WORDPRESS========]"
    wp core download --allow-root --path="$WP_PATH"
    
    echo "[========CREATING WP CONFIG========]"
    wp core config --path="$WP_PATH" --dbhost=mariadb:3306 --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
    
    echo "[========INSTALLING WORDPRESS========]"
    wp core install --path="$WP_PATH" --url="$DOMAIN_NAME" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root
    
    echo "[========CREATING ADDITIONAL USER========]"
    wp user create "$ALL_USER" "$ALL_EMAIL" --user_pass="$ALL_PASSWORD" --role=author --path="$WP_PATH" --allow-root
else
    echo "[========WORDPRESS ALREADY INSTALLED========]"
fi

#---------------------------------------------------php config---------------------------------------------------#

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# create a directory for php-fpm
mkdir -p /run/php
# start php-fpm service in the foreground to keep the container running

sudo chmod -R 755 /var/www/html/
/usr/sbin/php-fpm7.4 -F
