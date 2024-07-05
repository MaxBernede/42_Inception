# FROM inception:base

# RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client wget

# #get wordpress
# # Copy local files into the Docker image
# COPY wordpress-6.0-fr_FR.tar.gz /var/www/
# #DO BELOW WHEN NOT RUN ON MY MAC
# #RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www


# #untar it then remove the .tar not needed
# RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
# #gives access to root user
# RUN	chown -R root:root /var/www/wordpress			

# #Auto cli fill project
# # RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# #access to script
# # RUN chmod +x wp-cli.phar
# #move it in binaries
# # RUN mv wp-cli.phar /usr/local/bin/wp

# #copy auto_config
# COPY tools/auto_config.sh auto_config.sh
# RUN chmod +x /auto_config.sh

# #run our script in wordpress
# ENTRYPOINT ["bash", "auto_config.sh"]

FROM inception:base

EXPOSE 9000

# update and upgrade the system
# RUN apt-get update 
# RUN apt-get upgrade -y

# install the required packages
RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat sudo 

# copy the wordpress configuration script to the root directory in the container
COPY ./conf/wp_conf.sh /

# change the permission of the script to make it executable
RUN  chmod +x wp_conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wp_conf.sh"]

