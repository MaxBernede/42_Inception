#!/bin/bash

service mariadb start;

# Create database if it doesn't exist
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

# Create user if it doesn't exist and grant privileges
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

mariadb -e "FLUSH PRIVILEGES;"                                  # Refresh privileges

mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown              # Restart mysql

#use of exec mysqld to reduce stop time because PID == 1 ?
exec mysqld_safe                                              		# Start it again safe
