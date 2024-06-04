docker run --name --rm -d redis-stack -p 6379:6379  redis/redis-stack-server:latest

docker run --name mariadb --rm -d -v /Users/eis/Storage/docker-storage/mysql-data:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306  mariadb

docker run --name mongodb5 --rm -d -p 27017:27017 -v /Users/eis/Storage/docker-storage/mongo5-data:/data/db mongodb/mongodb-community-server:5.0-ubuntu2004

docker run --name debian --rm -d -it debian /bin/bash
docker run --name debian11 --rm -d -p 1347:1347 -it debian:11 /bin/bash
docker exec -it <container_name> bash
