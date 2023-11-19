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


### Nohup
```bash
nohup <COMMAND> > nohup.log 2>&1 &
nohup rsync -avz --partial --info=progress2 SOURCE_PATH/ TARGET_PATH/ > nohup.log 2>&1 &
```
