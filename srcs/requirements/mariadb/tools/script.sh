#!/bin/bash

#i think my program doesnt work because env not used. In case i run directly the docker, this trigger because it needs .env file to run
if [[ -z "${MYSQL_DATABASE}" || -z "${MYSQL_USER}" || -z "${MYSQL_PASSWORD}" || -z "${MYSQL_ROOT_PASSWORD}" ]]; then
    echo "Required environment variables (MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD) are not set."
    exit 1
fi

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



