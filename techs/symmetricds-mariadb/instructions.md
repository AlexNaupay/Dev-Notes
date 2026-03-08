# SymmetricDS + MariaDB

```bash
# Install MariaDB
docker run --name lim-maria -d -v /Users/alexh/Storage/DockerStorage/mariadb-lim:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306  mariadb
docker run --name aqp-maria -d -v /Users/alexh/Storage/DockerStorage/mariadb-aqp:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3307:3306  mariadb

# ------------------------------------------------------------------------------------------------------------------------------
# Install java
apt update && apt install default-jre mariadb-client --yes # Or default-jdk

# Both: Create database and user, important to give privileges
# Connect with some client ui like navicat or dbeaver or
mysql -h 127.0.0.1 -P 3306 -u root -p_alexh
CREATE DATABASE myapp_db;
CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypass';
GRANT ALL PRIVILEGES ON myapp_db.* TO 'myuser'@'%';
GRANT PROCESS ON *.* TO 'myuser'@'%';
FLUSH PRIVILEGES;
exit
mysql -h 127.0.0.1 -P 3306 -u myuser -pmypass myapp_db # Connect to database
CREATE TABLE clients (id uuid NOT NULL DEFAULT uuid_v7(), name VARCHAR(255), PRIMARY KEY (id)); # Create all tables before symmetricds

apt install wget unzip nano --yes
wget https://phoenixnap.dl.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.16/symmetric-server-3.16.11.zip -O symmetricds.zip
unzip symmetricds.zip
# ------------------------------------------------------------------------------------------------------------------------------
# Or run initial-setup.sh
cd symmetricds
# put nodex.properties inside engines folder

# Root node (first node)
bin/symadmin --engine lim1 create-sym-tables # mysql: SHOW TABLES LIKE 'sym_%';  # List symmetric tables
bin/dbimport --engine lim1 root-setup.sql
bin/sym --engine lim1  # Start the engine. SELECT node_id, registration_enabled FROM sym_node_security; # Check if registration is enabled
bin/symadmin --engine lim1 open-registration hyo-group-for-x hyo1
# SELECT node_id, registration_enabled, created_time, registration_time FROM sym_node_security; # Check if registration is enabled for hyo1

# Non-root node
bin/sym --engine hyo1  # Start the engine. SELECT node_id, registration_enabled FROM sym_node_security; # Check if registration is enabled
```

## Troubleshooting
```bash
# If node is not registered successfully, clean up (in root node)
DELETE FROM sym_node_security WHERE node_id = 'hyo1-id';
DELETE FROM sym_node WHERE node_id = 'hyo1-id';
SELECT node_id, registration_enabled, registered FROM sym_node_security; # Wanted: root | 1 | 1 . hyo1 | 0 | 1
bin/symadmin --engine lim1 sync-triggers
bin/symadmin --engine lim1 reload-node lim1-id
```

## Utils for mysql
```sql
SELECT DATABASE();  # Current database

USE myapp_db;  # Switch to database myapp_db
SHOW DATABASES;  # List databases
SELECT User, Host FROM mysql.user;  # List users
exit   # Quit

mariadb -h 127.0.0.1 -P 3306 -u root -p_alexh -D symdb -e "select * from clients" -- or
mariadb -h 127.0.0.1 -P 3306 -u root -p_alexh -D symdb -e "select * from clients"

mariadb --version
```