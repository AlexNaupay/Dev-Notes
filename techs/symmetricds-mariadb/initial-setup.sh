#!/bin/bash

apt update && apt install default-jre --yes # Or default-jdk
apt install wget unzip nano --yes

su - postgres -c "psql -c 'CREATE DATABASE myapp_db;'"

su - postgres -c "psql -c \"CREATE USER myuser WITH PASSWORD 'mypass';\""

su - postgres -c "psql -c 'GRANT ALL PRIVILEGES ON DATABASE myapp_db TO myuser;'"

su - postgres -c "psql -d myapp_db -c 'ALTER SCHEMA public OWNER TO myuser;'"

su - postgres -c "psql -d myapp_db -c 'GRANT ALL ON SCHEMA public TO myuser;'"

psql -U myuser -d myapp_db -c 'CREATE TABLE public.clients (
    id uuid NOT NULL DEFAULT uuidv7(),
    name varchar(255),
    CONSTRAINT clients_pkey PRIMARY KEY (id)
);'

wget https://phoenixnap.dl.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.16/symmetric-server-3.16.11.zip -O symmetricds.zip
unzip symmetricds.zip