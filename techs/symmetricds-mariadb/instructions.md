# SymmetricDS + Postgres

```bash
# Install Postgres
docker run --name lim-maria --rm -d -v /Users/alexh/Storage/DockerStorage/mariadb-lim:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3306:3306  mariadb
docker run --name aqp-maria --rm -d -v /Users/alexh/Storage/DockerStorage/mariadb-aqp:/var/lib/mysql -e MARIADB_ROOT_PASSWORD=_alexh -p 3307:3306  mariadb

# ------------------------------------------------------------------------------------------------------------------------------
# Install java
apt update && apt install default-jre --yes # Or default-jdk

# Both: Create database and user, important to give privileges
# Connect with some client ui like navicat or
su - postgres
psql
CREATE DATABASE myapp_db;
CREATE USER myuser WITH PASSWORD 'mypass';
GRANT ALL PRIVILEGES ON DATABASE myapp_db TO myuser;
exit
psql -U postgres -d myapp_db # Connect to database, or without exit from psql \c myapp_db [myuser];
ALTER SCHEMA public OWNER TO myuser;  # Important: myuser have to be owner
GRANT ALL ON SCHEMA public TO myuser;
# REASSIGN OWNED BY old_owner_username TO new_owner_username; # If you need to reassign existing objects
\dn  # List schemas
\q   # Quit
exit
psql -U myuser -d myapp_db # Connect to database, or without exit from psql \c myapp_db [myuser];
CREATE TABLE "public"."clients" ("id" uuid NOT NULL DEFAULT uuidv7(),"name" varchar(255) COLLATE "pg_catalog"."default", CONSTRAINT "clients_pkey" PRIMARY KEY ("id")); # Create all tables before symmetricds

apt install wget unzip nano --yes
wget https://phoenixnap.dl.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.16/symmetric-server-3.16.11.zip -O symmetricds.zip
unzip symmetricds.zip
# ------------------------------------------------------------------------------------------------------------------------------
# Or run initial-setup.sh
cd symmetricds
# put nodex.properties inside engines folder

# Root node (first node)
bin/symadmin --engine lim1 create-sym-tables # psql: \dt sym_*  # List symmetric tables
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

## Utils for psql
```sql
SELECT current_database();  # Current database
SELECT current_schema();  # Current schema
ALTER SCHEMA public OWNER TO myuser;
ALTER TABLE public.clients OWNER TO myuser;

\c myapp_db;  # Switch to database myapp_db
\c myapp_db myuser;  # Switch to database myapp_db with user myuser
\l  # List databases
\l+  # List databases with more details
\du  # List users
\dn  # List schemas
\q   # Quit

su - postgres -c "psql -d symdb -c 'select * from clients'" -- or
psql -U postgres -d symdb -c "select * from clients" -- or
sudo -u postgres psql -d symdb -c "select * from clients"

psql --version
```