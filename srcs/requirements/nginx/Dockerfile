FROM inception:base

RUN apt install -y nginx openssl

#create the folder to have the TSL files
RUN mkdir -p /etc/nginx/ssl
#give access to the root in case
RUN chmod 755 /var/www/html
#gives privileges to the main user
RUN chown -R www-data:www-data /var/www/html

#req create auto signed certificates
#-x509 precise the type of certificate
#-nodes put no password on the certif
#subj auto fill the responses to have a fully automated creation
RUN openssl	req									\
			-x509								\
			-nodes								\
			-newkey rsa:2048					\
			-days 365							\
			-out /etc/nginx/ssl/inception.crt	\
			-keyout /etc/nginx/ssl/inception.key \
			-subj "/C=NL/ST=AMS/L=Amsterdam/O=42/OU=Codam/CN=mbernede.42.fr/UID=mbernede"

#create folder for the config files
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Added to check if the 443 problem is because of that
EXPOSE 443 

#CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["nginx", "-g", "daemon off;"]