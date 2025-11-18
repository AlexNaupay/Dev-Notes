# Replication
### Paso 1: Configuración del Servidor Maestro
1. Edita el archivo de configuración (my.cnf o my.ini):
/etc/mysql/mariadb.conf.d/50-server.cnf

```bash
[mysqld]
server-id = 1 # Debe ser un valor único en la topología de replicación (from 1 to 232 − 1)
log_bin = /var/log/mysql/mysql-bin.log
binlog_do_db = nombre_de_tu_base_de_datos # Opcional: limita la replicación a una base de datos específica
```

2. Reinicia el servidor MySQL:

`sudo systemctl restart mysql`

3. Crea un usuario de replicación:

```sql
CREATE USER 'tu_usuario'@'%' IDENTIFIED BY 'tu_contraseña';
GRANT REPLICATION SLAVE ON *.* TO 'tu_usuario'@'%';
FLUSH PRIVILEGES;
```

4. Obtiene la posición actual del binlog:
```sql
SHOW MASTER STATUS;
```

### Paso 2: Configuración del Servidor Esclavo
1. Edita el archivo de configuración (my.cnf o my.ini):
/etc/mysql/mariadb.conf.d/50-server.cnf

```bash
[mysqld]
server-id = 2 # Debe ser un valor único en la topología de replicación
```

2. Reinicia el servidor MySQL:

`sudo systemctl restart mysql`

3. Inicia sesión en MySQL y ejecuta estos comandos
```sql
CHANGE MASTER TO
    MASTER_HOST = 'dirección_ip_del_servidor_maestro',
    MASTER_USER = 'tu_usuario',
    MASTER_PASSWORD = 'tu_contraseña',
    MASTER_LOG_FILE = 'valor_de_File',
    MASTER_LOG_POS = valor_de_Position;

START SLAVE;

SHOW SLAVE STATUS\G
```
Asegúrate de que Slave_IO_Running y Slave_SQL_Running estén configurados como "Yes" y que no haya errores en el estado de la replicación.

### troubleshooting
```sql
STOP SLAVE;
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; 
START SLAVE;
```

# Time zone
```sql
SELECT @@global.time_zone;
SET GLOBAL time_zone = '-5:00'

SELECT @@session.time_zone;
SET time_zone = '-5:00'
 ```


# Install mysql old version mysql 5.7
```sql
wget https://dev.mysql.com/get/mysql-apt-config_0.8.18-1_all.deb
dpkg -i mysql-apt-config_0.8.18-1_all.deb
apt update
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys NO_PUBKEY
apt install mysql-community-server
 ```


# Create user with privileges
```bash
# % : Any
# CREATE DATABASE db_name CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER 'MY_USER'@'localhost' IDENTIFIED BY 'PASS';
GRANT USAGE ON *.* TO 'MY_USER'@'localhost';  # Do nothing

GRANT CREATE,REFERENCES,INDEX ON MY_DB.* TO 'MY_USER'@'localhost';  # Create tables
GRANT SELECT, INSERT, UPDATE ON MY_DB.* TO 'MY_USER'@'localhost';  # On All My_DB.tables
GRANT SELECT, INSERT, UPDATE, CREATE,REFERENCES,INDEX ON MY_DB.* TO `MY_USER`@`localhost`  # One line
GRANT DELETE ON MY_DB.TABLE_NAME TO 'MY_USER'@'localhost';
# GRANT DELETE ON MY_DB.password_resets TO 'MY_USER'@'localhost';   # Laravel
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'MY_USER'@'localhost';
 ```

 ### User with full privileges (not recommended)
 ```bash
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON *.* TO 'new_user'@'localhost';
FLUSH PRIVILEGES;
 ```