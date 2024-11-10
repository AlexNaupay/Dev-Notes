# Docker commands
```bash
docker build -t NAME:TAG [-f FILE.dockerfile] <.|PATH>
# docker build -t redis-stack -f redis-stack.dockerfile .

docker run --name CONTAINER_NAME -d -p HOST_PORT:CONTAINER_PORT IMAGE_NAME
#docker run --name redis-stack -d -p 6379:6379 redis/redis-stack-server:latest

docker ps -a --size
docker stats CONTAINER 
docker exec -it CONTAINER bash
docker logs -f CONTAINER
docker inspect CONTAINER

# Save/load image
docker save -o FILE_TARGET.tar IMAGE_NAME 
docker save IMAGE_NAME > IMAGE_NAME.tar
docker load -i FILE_SOURCE.tar

# Export/import container
docker export -o CONTAINER_NAME_TARGET.tar CONTAINER
docker import CONTAINER_NAME_TARGET.tar

```

## Docker utils
```bash
docker run --name --rm -d redis-stack -p 6379:6379  redis/redis-stack-server:latest

docker run --name mariadb --rm -d -v /Users/eis/Storage/docker-storage/mysql-data:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306  mariadb

docker run --name mongodb5 --rm -d -p 27017:27017 -v /Users/eis/Storage/docker-storage/mongo5-data:/data/db mongodb/mongodb-community-server:5.0-ubuntu2004

docker run --name minio --rm -d -p 9000:9000 -p 9001:9001 -v /Users/eis/Storage/docker-storage/minio-data:/data quay.io/minio/minio server /data --console-address ":9001"

docker run --name debian --rm -d -it debian /bin/bash
docker run --name debian11 --rm -d -p 1347:1347 -it debian:11 /bin/bash
docker exec -it <container_name> bash
```


## Dockerfile Example
```bash
FROM debian:11
VOLUME ["HOST_DIR", "CONTAINER_DIR"]
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 -O /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
WORKDIR /app
COPY . .
RUN chmod +x ./start.sh
CMD ["./start.sh"]
```

## Docker Swarm
```bash
docker swarm init
docker swarm join-token manager
docker node ls
docker node inspect self
docker node inspect lv81fdas0w17izk6er5f984ba
docker node inspect --pretty self
docker swarm leave
docker swarm leave --force 
```
