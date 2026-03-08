#!/bin/bash

apt update -qqq
apt install default-jre mariadb-client --yes -qqq # Or default-jdk
apt install wget unzip nano --yes -qqq

mariadb -h 127.0.0.1 -u root -p_alexh -e "CREATE DATABASE IF NOT EXISTS myapp_db;"
mariadb -h 127.0.0.1 -u root -p_alexh -e "CREATE USER IF NOT EXISTS 'myuser'@'%' IDENTIFIED BY 'mypass';"
mariadb -h 127.0.0.1 -u root -p_alexh -e "GRANT ALL PRIVILEGES ON myapp_db.* TO 'myuser'@'%';"
mariadb -h 127.0.0.1 -u root -p_alexh -e "GRANT PROCESS ON *.* TO 'myuser'@'%';"
mariadb -h 127.0.0.1 -u root -p_alexh -e "FLUSH PRIVILEGES;"

mariadb -h 127.0.0.1 -u myuser -pmypass -D myapp_db -e "CREATE TABLE IF NOT EXISTS clients (
    id uuid NOT NULL DEFAULT uuid_v7(),
    name VARCHAR(255),
    PRIMARY KEY (id)
);"

wget https://phoenixnap.dl.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.16/symmetric-server-3.16.11.zip -O symmetricds.zip
unzip symmetricds.zip