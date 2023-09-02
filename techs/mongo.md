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
