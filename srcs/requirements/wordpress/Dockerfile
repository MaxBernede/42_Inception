FROM inception:base

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat sudo

COPY ./conf/*.sh /

RUN  chmod +x /wait_container.sh /wp_conf.sh

ENTRYPOINT ["./wp_conf.sh"]

