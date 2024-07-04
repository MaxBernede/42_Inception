#!/bin/bash

if [[ -z "${MYSQL_DATABASE}" || -z "${MYSQL_USER}" || -z "${MYSQL_PASSWORD}" || -z "${MYSQL_ROOT_PASSWORD}" ]]; then
    echo "Required environment variables (MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD) are not set."
    exit 1
fi
echo "my values : ${MYSQL_DATABASE} ${MYSQL_USER} ${MYSQL_PASSWORD} ${MYSQL_ROOT_PASSWORD}"

#start mariadb to be able to run the cmds i need
service mariadb start;
sleep 1

# Create database if it doesn't exist
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

# Create user if it doesn't exist and grant privileges
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

# Modify the root user password
# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Refresh privileges
mariadb -e "FLUSH PRIVILEGES;"

#restart mysql
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

#run it again
exec mysqld_safe
