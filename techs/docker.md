docker run --name redis-stack -p 6379:6379 -d --rm redis/redis-stack-server:latest
docker run --name mariadb -v /Users/eis/Storage/mysql/data:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306 -d --rm mariadb
