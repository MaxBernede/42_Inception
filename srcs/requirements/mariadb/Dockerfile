FROM inception:base

RUN apt-get install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#COPY tools/init.sql /etc/mysql/init.sql
COPY tools/script.sh .
RUN chmod 777 ./script.sh

# Expose port 3306 for MariaDB
EXPOSE 3306

#run the script that create dbb and user
ENTRYPOINT ["bash", "script.sh"]

