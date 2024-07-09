FROM inception:base

RUN apt-get install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh .
RUN chmod 777 ./script.sh

# Expose port 3306 for MariaDB, not sure its needed as docker.yml expose
EXPOSE 3306

#run the script that create dbb and user
ENTRYPOINT ["./script.sh"]

