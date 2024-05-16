docker run --name --rm -d redis-stack -p 6379:6379  redis/redis-stack-server:latest

docker run --name mariadb --rm -d -v /Users/eis/Storage/docker-storage/mysql-data:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306  mariadb

docker run --name mongodb5 --rm -d -p 27017:27017 -v /Users/eis/Storage/docker-storage/mongo5-data:/data/db mongodb/mongodb-community-server:5.0-ubuntu2004

docker exec -it <container_name> bash