chmod 777 -R ~/datas
#the 2 folders needs to be erased from the containers itself because no access rights
rm -rf ~/datas
rm -rf db wordpress
rm ./srcs/requirements/wordpress/wordpress-6.0-fr_FR.tar.gz
docker rm -f $(docker ps -a -q) 
docker system prune -af
docker volume rm $(docker volume ls -q)
cd srcs
# docker-compose up -d --no-deps --build