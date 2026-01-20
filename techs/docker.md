# Docker commands
```bash
docker build -t NAME:TAG [-f FILE.dockerfile] <.|PATH>
# docker build -t redis-stack -f redis-stack.dockerfile .

docker build --platform linux/amd64,linux/arm64 --push -t alexnaupay/nginx-hostname:latest .

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

docker container cp PATH/SRC mongo5:/PATH/DEST
```

## Docker utils
```bash
docker run --name --rm -d redis-stack -p 6379:6379  redis/redis-stack-server:latest

docker run --name mariadb --rm -d -v /Users/eis/Storage/docker-storage/mysql-data:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306  mariadb

docker run --name mongodb5 --rm -d -p 27017:27017 -v /Users/eis/Storage/docker-storage/mongo5-data:/data/db mongodb/mongodb-community-server:5.0-ubuntu2004

docker run --name mongodb8 --rm -d -p 27018:27017 -v /Users/eis/Storage/docker-storage/mongo8-data:/data/db mongodb/mongodb-community-server:8.0-ubuntu2204

docker run --name minio --rm -d -p 9000:9000 -p 9001:9001 -v /Users/eis/Storage/docker-storage/minio-data:/data quay.io/minio/minio server /data --console-address ":9001"

docker run --name mailpit --rm -d -p 8025:8025 -p 1025:1025 -v /Users/eis/Storage/docker-storage/mailpit-data:/data axllent/mailpit

docker run --name postgres --rm -d -p 5432:5432 -e POSTGRES_PASSWORD=_alexh -v /Users/eis/Storage/docker-storage/postgres-data:/var/lib/postgresql/data postgres:17.5-alpine3.22

docker run --name postgres18 --rm -d -v /Users/eis/Storage/docker-storage/postgres18-data:/var/lib/postgresql -e POSTGRES_PASSWORD=_alexh -p 5432:5432  postgres:18.1-trixie

# docker run --name PROJECT_NAME --rm -d -v LARAVEL_PROJECT_PATH:/var/www/html  -p 8001:80  php7.2-for-laravel
docker run --name requirements --rm -d -v /Users/eis/Code/requerimientos:/var/www/html  -p 8001:80  php7.2-for-laravel

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

## Docker Compose
```bash
docker compose restart
docker compose restart servicio-web

docker compose build  # --no-cache
docker compose build servicio-web

docker compose up --build --force-recreate -d  # build and recreate
docker compose up --build --force-recreate -d servicio-api

# Detener y eliminar contenedores, luego reiniciar (limpia contenedores antiguos):
docker compose down && docker compose up -d
```

## References
[Orbstack multiplatform](https://docs.orbstack.dev/docker/images)

## Delete
```bash
docker builder prune --all
docker system prune -a --volumes
```