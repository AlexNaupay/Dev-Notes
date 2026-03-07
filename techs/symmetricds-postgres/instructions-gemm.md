# SymmetricDS + Postgres

```bash
# Install Postgres
docker run --name lim-1 -d -p 5432:5432 -e POSTGRES_PASSWORD=_alexh -v /path/to/lim-1:/var/lib/postgresql postgres:18
docker run --name hyo-1 -d -p 5433:5432 -e POSTGRES_PASSWORD=_alexh -v /path/to/hyo-1:/var/lib/postgresql postgres:18

# Install java
apt install default-jre # Or default-jdk

# Both: Create database and user, important to give privileges
# Connect with some client ui like navicat or
# su - postgres then psql
CREATE DATABASE myapp_db;
CREATE USER myuser WITH PASSWORD 'mypass';
GRANT ALL PRIVILEGES ON DATABASE myapp_db TO myuser;
apt install wget unzip nano
wget https://phoenixnap.dl.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.17/symmetric-server-3.17.0.zip?viasf=1

psql -U postgres -d myapp_db
ALTER SCHEMA public OWNER TO myuser;  # Important: myuser have to be owner
# GRANT ALL ON SCHEMA public TO myuser;
# REASSIGN OWNED BY old_owner_username TO new_owner_username; # If you need to reassign existing objects
\dn  # List schemas
\q   # Quit

unzip symmetricds.zip
cd symmetricds
# put nodex.properties inside engines folder

# Root node (first node)
bin/symadmin --engine lim1 create-sym-tables # psql: \dt sym_*  # List symmetric tables
bin/sym --engine lim1  # Start the engine. SELECT node_id, registration_enabled FROM sym_node_security; # Check if registration is enabled

# Non-root node
bin/sym --engine hyo1  # Start the engine. SELECT node_id, registration_enabled FROM sym_node_security; # Check if registration is enabled

# Root node
INSERT INTO sym_channel (channel_id, processing_order, max_batch_size) VALUES ('data', 1, 100000);
INSERT INTO sym_router (router_id, source_node_group_id, target_node_group_id, router_type, create_time, last_update_time) VALUES
    ('lim_to_hyo', 'lim-group-for-x', 'hyo-group-for-x', 'default', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('hyo_to_lim', 'hyo-group-for-x', 'lim-group-for-x', 'default', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
# for each table you want to replicate (clients)
INSERT INTO sym_trigger (trigger_id, source_table_name, channel_id, sync_on_insert, sync_on_update, sync_on_delete, create_time, last_update_time) VALUES
    ('clients_trigger', 'clients', 'data', 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
# for each router you want to use for the trigger (key for bidirectional sync)
INSERT INTO sym_trigger_router (trigger_id, router_id, create_time, last_update_time) VALUES
    ('clients_trigger', 'lim_to_hyo', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('clients_trigger', 'hyo_to_lim', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

bin/symadmin --engine lim1 reload-node lim1-id
bin/symadmin --engine hyo1 reload-node hyo1-id

# Root node
bin/symadmin --engine lim1 sync-triggers # SELECT trigger_name FROM information_schema.triggers WHERE trigger_name LIKE 'sym_%';

```

## Utils for psql
```sql
SELECT current_database();  # Current database
SELECT current_schema();  # Current schema
\c myapp_db;  # Switch to database myapp_db
\c myapp_db myuser;  # Switch to database myapp_db with user myuser
\l  # List databases
\l+  # List databases with more details
\du  # List users
\dn  # List schemas
\q   # Quit
```