docker run --rm -d --name redis-stack -p 6379:6379  redis/redis-stack-server:latest
docker run --rm --name mariadb -v /Users/eis/Storage/mysql/data:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306 -d mariadb
