### Add user
`sudo useradd <username>`

`sudo useradd -m <username>` // With home directory

`useradd -s /usr/bin/zsh <username>`  // With shell

`useradd -e 2019-01-22 <username>`  // Expire date



### Locals
```bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
dpkg-reconfigure locales
```

### Packages and versions
```bash
apt-cache madison <package-search>
apt install <packahe-name>=<version>
```


### Packages and versions
```bash
nohup rsync -avz --partial --info=progress2 JAVA_11/ test/ > salida_rsync.log 2>&1 &
```
