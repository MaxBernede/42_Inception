FROM debian:buster

RUN apt update -y && apt upgrade -y && apt install -y php-fpm php-mysqli curl wget
RUN apt-get install -y php7.3 php-mysql mariadb-client

#get wordpress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
#untar it then remove the .tar not needed
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
#gives access to root user
RUN		chown -R root:root /var/www/wordpress			

#Auto cli fill project
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#access to script
RUN chmod +x wp-cli.phar
#move it in binaries
RUN mv wp-cli.phar /usr/local/bin/wp

#copy auto_config
COPY tools/auto_config.sh auto_config.sh

#run our script in wordpress
ENTRYPOINT ["bash", "auto_config.sh"]
