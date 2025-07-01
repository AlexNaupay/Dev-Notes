# Replication
### server1, server2, ..., servern
In /etc/mongod.conf
```
replication:
    replSetName: nombre_de_tu_replica
```

### server 1
`mongo`

```
rs.initiate({
  _id: "nombre_de_tu_replica",
  members: [
    { _id: 0, host: "server1:27017" }, // Cambia server1 al nombre o dirección IP de tu primer servidor
    { _id: 1, host: "server2:27017" }  // Cambia server2 al nombre o dirección IP de tu segundo servidor
  ]
})
```

// Add new replica set member

`mongo`

`rs.add("serverx:port")`


### sailjs connection config
connections.js and sessions.js

```
url: 'mongodb://usuario:contraseña@hostname1:27017,hostname2:27017,hostname3:27017/base_de_datos?replicaSet=nombre_del_replica_set&readPreference=secondary',
```


# Export and Import

### mongoexport
`mongodump --db db_name --out folder_bson_files`

`mongodump --db db_name --archive=archive_path.gz`

 || Latest versions ||


`mongodump --nsInclude="db_name.*" --archive=archive_path.gz`



### mongoimport
`mongorestore --db db_name --drop folder_bson_files`

`mongorestore --db db_name --archive=archive_path.gz`

`mongorestore [--nsInclude="db_name.*"] --archive=archive_path.gz`

# Install
```bash
apt install gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | tee /etc/apt/sources.list.d/mongodb-org-8.0.list
apt update
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod
# You may requiere to change Processors type to host for virtualvm
```

# Enable auth and root user
```javascript
use admin
db.createUser({ user: "root", pwd: "a_strong_password", roles: ["root"]})

use mydatabase
db.createUser({ user: "user", pwd: "userpass", roles: [{ role: "dbAdmin", db: "mydatabase" }, { role: "readWrite", db: "mydatabase" } ]})

// List users
db.getUsers()

db.updateUser("user",{roles: [{ role: "readWrite", db: "mydatabase" }]})  // Overwrite all roles

// Update password and overwrite roles
db.updateUser("geoaccess",{pwd: "NEW_PASSWORD",roles: [{ role: "readWrite", db: "geoaccessdb" }]})

// Drop user
db.dropUser("username")

// Role info
db.runCommand({ rolesInfo: "dbAdmin", showPrivileges: true })

```

```bash
nano /etc/mongod.conf
security:
  authorization: enabled
```
```bash
mongosh --host localhost --port 27017 --username user --password "pass" --authenticationDatabase admin
```