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

### Disks and partitions
```bash
sudo lsblk
df -h
```

### Sury: php, etc
```bash
apt  install software-properties-common ca-certificates lsb-release apt-transport-https wget gnupg
sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/sury.list'
wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
apt update
export HISTSIZE=5000
```


### A server with multiple network interfaces
```bash
# Show interfaces
ip addr
nmcli device status
netstat -i
cat /proc/net/dev
ls /sys/class/net/
```

```conf
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens18
iface ens18 inet static
	address 10.10.1.124/24
	network 10.10.1.0
        up ip route add 10.10.0.0/16 via 10.10.1.1 dev ens18
        down ip route del 10.10.0.0/16 via 10.10.1.1 dev ens18

allow-hotplug ens19
iface ens19 inet static
    address 50.50.1.124/24
    network 50.50.1.0

# Interface to connect to internet
allow-hotplug ens20
iface ens20 inet static
	address 192.168.1.124/24
    network 192.168.1.0
	gateway 192.168.1.1
	dns-nameservers 8.8.8.8 8.8.4.4 1.1.1.1
```

### My public IP
```bash
# Install dnsutils
apt install dnsutils

# dig=domain information groper
dig +short txt ch whoami.cloudflare @1.0.0.1

dig +short myip.opendns.com @resolver1.opendns.com

dig TXT +short o-o.myaddr.l.google.com @ns1.google.com

dig +short txt ch whoami.cloudflare @1.0.0.1

# IPv6
dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com

host myip.opendns.com resolver1.opendns.com

curl checkip.amazonaws.com
curl ifconfig.me
curl icanhazip.com
curl ipecho.net/plain
curl ifconfig.co
```

### Virtualbox
```bash
VBoxManage startvm "VM name" --type headless
VBoxHeadless --startvm <uuid|name>
VBoxManage controlvm <uuid|name> acpipowerbutton
```

### Append a line of text to a file by using the >> operator:
`echo "hello world" >> my_file.txt`

### Config for .vimrc
```bash
set showmode
set autoindent
set tabstop=4
set expandtab
syntax on
```

```bash
less FILE  # Use / to search on content
```