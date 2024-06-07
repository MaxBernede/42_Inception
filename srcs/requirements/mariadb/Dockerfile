FROM debian:latest

RUN apt update && apt upgrade && apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY tools/init.sql /etc/mysql/init.sql
COPY tools/script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh

CMD ["./script.sh"]

# Expose port 3306 for MariaDB
# EXPOSE 3306

# Copy custom configuration files, if any
# COPY ./path/to/custom/config.cnf /etc/mysql/conf.d/


# Run the MariaDB server