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
```bash
usermod -a -G groupname username  # Take effect in next start
newgrp groupname # Take effect in current bash session
``` 

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

# Troubleshutting
FS0:  # : Shif + ñ
edit startup.nsh # put: FS0:\EFI\debian\grubaa64.efi
# CTRL+S to save, ENTER to confirm, CTRL+Q to quit editor
reset # reset the vm

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

# Print pretty json
echo '{"foo": "lorem", "bar": "ipsum"}' | python -m json.tool
```

### Alpine linux
```bash
apk update
apk upgrade
apk add curl
apk del <package>
```

### Change editor
```bash
export EDITOR=nano
```

### Journalctl
```bash
journalctl -b  # Events from this boot
journalctl --list-boots
journalctl --since "2023-01-05" --until "1 hour ago"
journalctl -b | grep LOGIN  # Fails and success
journalctl -b _COMM=crond|sshd
```

### lnav
```bash
# https://lnav.org/features
apt install lnav
lnav -t /var/log/nginx/access.log
lnav access*
lnav    # Open and merge all /var/log/* files

# ESC then ;
select log_procname, count(*) from syslog_log group by log_procname;
SELECT log_procname,log_time FROM syslog_log where log_procname='gnome-software';
select c_ip, count(*) from access_log where cs_uri_stem like '/wsiotramite%'  group by c_ip
select c_ip, count(*) as counter from access_log group by c_ip
```

### fsck
```bash
fsck /dev/sda1 # Important: begin with /
fsck -yf /dev/sda1
```

### safe delete files
```bash
sudo apt install secure-delete
srm -v -z /ruta/al/archivo # -r:recursive
srm -l -v -r /datos/sensibles  #-l: Lento

sudo apt install wipe
wipe -r -q -D /ruta/a/la/carpeta # -r:recursivo, -D:Delete(-k:no-delete), -q:no verbose

shred -n 3 -z -v -u /path/file
# -v: Muestra el progreso (verbose)
# -n 10: Sobrescribe 10 veces (por defecto son 3)
# -z: Añade una pasada final con ceros para ocultar el shredding
# -u: Elimina el archivo después de sobrescribirlo
# For folders
find /ruta/de/la/carpeta -type f -exec shred -v -n 3 -z -u {} \;
rm -rf /ruta/de/la/carpeta
```

## openssl
```bash
# https://medium.com/@noelpulido1229/how-to-add-self-signed-ssl-certificate-in-nodejs-server-ce9d53c17a9c
openssl genrsa -aes256 -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1826 -out rootCA.crt

openssl req -new -nodes -out server.csr -newkey rsa:4096 -keyout server.key
openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 730 -sha256 -extfile server.v3.ext 

## Better?
openssl genpkey -algorithm RSA -aes-256-cbc -out rootCA.key -pkeyopt rsa_keygen_bits:4096 # generar la CA
openssl req -x509 -new -key rootCA.key -days 3650 -out rootCA.crt -extensions v3_ca -config rootCA.cnf  # crear el certificado raíz

openssl req -new -nodes -out server.csr -newkey rsa:4096 -keyout server.key
openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 1825 -sha256 -extfile server.v3.ext
# server.crt, server.key (nginx, nginx P:600)
# rootCA.crt (optional public to install)
# rootCA.key (private)


# Double click on rootCA.crt to install
openssl s_client -connect example.com:443 -showcerts
```

```sh
# server.v3.ext File
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE  # No sign others
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = devlabs.com
IP.1 = ip address of your server

# rootCA.cnf file
[ req ]
default_md = sha256
distinguished_name = dn

[ dn ]
CN = Mi Root CA

[ v3_ca ]
basicConstraints = critical, CA:TRUE
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
```