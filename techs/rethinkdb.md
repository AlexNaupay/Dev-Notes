# Install

```bash
export CODENAME=`lsb_release -cs`
echo "deb https://download.rethinkdb.com/repository/debian-$CODENAME $CODENAME main" | tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- https://download.rethinkdb.com/repository/raw/pubkey.gpg | apt-key add -
apt update
apt install rethinkdb
```

Copy config files to /etc/rethinkdb/instances.d

`cp /etc/rethinkdb/abc.conf.sample /etc/rethinkdb/instances.d/xyz.conf`


```bash
systemctl restart rethinkdb
```

### Set replication from command line

`rethinkdb --bind all`

`rethinkdb --join IP_OF_FIRST_MACHINE:29015 --bind all`
