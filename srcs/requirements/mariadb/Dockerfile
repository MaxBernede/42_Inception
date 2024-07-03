FROM debian:buster

RUN apt-get update -y 
RUN apt-get upgrade -y 
RUN apt-get install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
#COPY tools/init.sql /etc/mysql/init.sql
COPY tools/script.sh .

#chown fixed the problem of failign to start
#change owner of the path so mysql have it to run properly
RUN mkdir /run/mysqld 
RUN chown -R mysql:root /run/mysqld
RUN chmod 777 script.sh

# Expose port 3306 for MariaDB
EXPOSE 3306

#run the script that create dbb and user
ENTRYPOINT ["bash", "script.sh"]

