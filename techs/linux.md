### Add user
`sudo useradd <username>`

`sudo useradd -m <username>` // With home directory

`useradd -s /usr/bin/zsh <username>`  // With shell

`useradd -e 2019-01-22 <username>`  // Expire date



### Locals
```bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
ln -s /sbin/locale-gen /bin/locale-gen
ln -s /sbin/update-locale /bin/update-locale

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

### Debian old packages
```bash
nano /etc/apt/sources.list

deb http://archive.debian.org/debian/ jessie main non-free contrib
deb-src http://archive.debian.org/debian/ jessie main non-free contrib
deb http://archive.debian.org/debian-security/ jessie/updates main non-free contrib
deb-src http://archive.debian.org/debian-security/ jessie/updates main non-free contrib

apt-get install debian-archive-keyring
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com 7638D0442B90D010
apt update
apt upgrade
dpkg-reconfigure locales
```

### History
```bash
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTSIZE=5000
```

### Add user to group
`usermod -a -G groupname username`


### Sury: php, etc
```bash
apt  install software-properties-common ca-certificates lsb-release apt-transport-https wget gnupg
sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/sury.list'
wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
apt update
export HISTSIZE=5000
```