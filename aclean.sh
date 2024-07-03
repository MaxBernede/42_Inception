rm -rf ~/data
rm -rf db wordpress
docker rm -f $(docker ps -a -q) 
docker system prune -af
docker volume rm $(docker volume ls -q)
cd srcs
# docker-compose up -d --no-deps --build