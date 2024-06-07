#!/bin/bash

#start mysql to be able to run the cmds i need
service mysql start;

#easy, create DBB
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

#create user
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

#modify the root user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

#refresh so mysql use this new rules
mysql -e "FLUSH PRIVILEGES;"

#restart mysql
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

#run it again
exec mysqld_safe



