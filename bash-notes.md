## change mod for all files --recursive
    find <DIR|.> -type f -exec chmod 644 {} +

##  change files and directories recursively
    chmod -R 755 ./**

##  change mod for directories recursively
find <DIR|.> -type d -exec chmod 755 {} \;

##  delete files recursively
find <DIR|.> -type f -name "*.sql" -delete
find . -type d -name node_modules -exec rm -rf {} \;

##  list files recursively
find <DIR|.> -type f -name "*.sql"

## recursive list 
    ls -R

## que archivos son diferentes
    diff --brief -r dir1/ dir2/

## Replace text 
```bash
sed -i 's/old_string/new_string/' file.ext # s: substitution, /: delimiter , default: First ocurrence in each line
sed -i 's/old_string/new_string/2' file.ext # s: substitution, /2: Second ocurrence in each line
sed -i 's/old_string/new_string/g' file.ext # s: substitution, /g: All ocurrences in each line
sed -i 's/old_string/new_string/g' *
sed -i 's/UtilsService.log/sails.log.debug/g' * 

# https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/
```

## Replace text recursively
find DIR -type f -name "*.php" -exec grep -Iq 'CURRENT_WORD' {} \; -exec sed -i 's/CURRENT_WORD/NEW_WORD/g' {} \;

## ver conexiones ssh a host
    netstat -ap | grep 'ESTABLISHED.*ssh'
   
## ver puertos, etc en uso 
    netstat -tulpn
    ss -tulpnr

    Este comando mostrará una lista de todas las conexiones de red activas en tu sistema, junto con el proceso que las está utilizando y el puerto que están usando. Aquí está lo que significan las opciones de este comando:

        -t: muestra sólo las conexiones de red TCP (Protocolo de Control de Transmisión).
        -u: muestra sólo las conexiones de red UDP (Protocolo de Datagrama de Usuario).
        -l: muestra sólo las conexiones de red que están escuchando en algún puerto.
        -p: muestra el proceso que está utilizando la conexión.
        -n: muestra los números de puerto en lugar de los nombres de servicio.

    Usando estas opciones, el comando netstat -tulpn te mostrará una lista de todos los servicios y puertos que están en uso en tu sistema Debian.

## find text into file
    grep -r <TEXT_SEARCH> <.|directory>

## package's files
    dpkg -L <installed_package>

## version SSOO - Debian
`lsb_release -a`

`cat /etc/os-release`

## on terminal
    CTRL+R : Search in history

## search in history
    history | grep <command>

## compress and decompress
    tar zcfv <file_name>tar.gz  <directory_to_compress>  // compress
    tar zxfv <file_name>tar.gz  //decompress
    gzip -d <file>.zip  //decompress
    zip <file>.zip <directory>  //compress

## mount
    nf -h  ==> Ver montados

## ver historial de inicios del sistema
    last  // ver historial de inicios del sistema
    journalctl --list-boots
    last reboot|shutdown


## Functions
    function debiantest() { ( cd ~/vagrantvms/debian78test && vagrant $* ) }
    function myjava() { ( ~/dev-tools/jdk1.8.0_121/bin/java $* ) }
    function mywsimport() { ( ~/dev-tools/jdk1.8.0_121/bin/wsimport $* ) }

## curl and soap
    curl -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:<ACTION_NAME>"  -d @<FILE_REQUEST>.xml -X POST <END_POINT>
    curl -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:getDatosPrincipales:"  -d @request2.xml -X POST http://ws.pide.gob.pe/ConsultaRuc
    curl -H "Content-Type: text/xml; charset=utf-8" -H "SOAPAction:actualizarcredencial"  -d @request.xml -X POST https://ws5.pide.gob.pe/services/ReniecConsultaDni

## Change hardware clock (BIOS)
    date -s "2023-01-31 15:05:10"
    hwclock --systohc
    hwclock -r

## Run a command every -n=5 seconds
    watch -n 5 free -m

## startup
    /etc/init.d/<binary_file>
    chkconfig <binary> <on|off>  // Ej: chkconfig httpd on //centos
    update-rc.d <binary> defaults //Debian

## Services
    systemctl <status|start|stop|reload> <service_name>  //centos
    service <service_name> <status|start..>  //debian

# Network 
#### Verificar si NIC  está conectado a la red
    cat /sys/class/net/eno1/carrier 

#### Verificar si interfaz está habilitada
    cat /sys/class/net/eno1/operstate

#### Traceroute
    traceroute -T <dirección IP o nombre de dominio>  // -U:UDP, -T:TCP, -I:ICMP(ping)   

#### Enruters
    post-up ip route add 10.10.0.0/16 via 10.10.1.1 dev ens18
    up ip route add 10.10.0.0/16 via 10.10.1.1 dev ens18
    down ip route del 10.10.0.0/16 via 10.10.1.1 dev ens18
    pre-down systemctl stop myservice

#### MacOS (unix)
```bash
# https://www.unix.com/man_page/osx/8/route/
sudo route -nv add -net 10.10.10.0/24 GATEWAY
sudo route -nv add -net 10.10.10.0/24 192.168.100.1
sudo route -nv add -net 10.10.10.0/24 -interface ppp0

sudo route -nv add -host 10.10.10.25 192.168.100.1
# sudo route -nv add -host 192.168.49.2 192.168.18.76

sudo route add -net 192.168.49.0/24  192.168.18.76
# On linux to forward then restart machine
# /etc/sysctl.conf
net.ipv4.ip_forward=1 # allows the server to act as a router
```

# VirtualBox
    VBoxManage startvm NAME --type headless
    VBoxManage controlvm NAME poweroff|pause|reset

# Developers
## maven
    mvn install:install-file -Dfile=target/libreria-onpe-1.0.jar -DgroupId=pe.gob.onpe.libreria -DartifactId=libreria-onpe -Dversion=1.0 -Dpackaging=jar

## pm2 nodejs process manager
    NODE_ENV_FILE=[VAL] pm2 start app.js
    pm2 list
    pm2 log ID
    pm2 show ID
    mp2 monit
    pm2 startup -u system_username
    pm2 save
    pm2 unstartup systemd

## Network centos
`nmcli d`

`vi /etc/sysconf ig/network-scripts/ifcfg-[network_device_name`

ONBOOT="yes"


## Size of folders
`du -sh *`

`du -sh PATH/*`

`du -sh PATH`


`du [options] [directory/file]`

`du -sh [directory]/*  # -s: summary, /* List directories` 

rsync -avz --partial --exclude '*/ubifoto1/' --exclude '*/ubifoto2/' --exclude '*/helicorders/' root@10.10.210.48:/data/paginasweb/fotos-tiempo-real/* .


### Permissions fro laravel projects
```bash
chown -R www-data:www-data /path/to/your/laravel/root/directory
usermod -a -G www-data ftp_user # if you have ftp user

cd LARAVEL_PROJECT
chown -R $USER:www-data .
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;

chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
```

### sftp Jailed user
```bash
# As root user
/sbin/groupadd sftp_users
/sbin/useradd -G sftp_users -s /sbin/nologin -m USER
passwd USER
mkdir FILES # on user_home
chown root:root /home/USER # Important!!!!!!!!!!!!! root owner
chmod 700 FILES
/sbin/usermod -d /FILES USER
chown -R USER FILES

nano /etc/ssh/sshd_config

Comment: 
# Subsystem   sftp    /usr/lib/openssh/sftp-server

Add:
Subsystem sftp internal-sftp
Match Group sftp_users
  X11Forwarding no
  AllowTcpForwarding no
  ChrootDirectory /home/%u
  ForceCommand internal-sftp

Example:
# :path after ChrootDirectory (It means real path: /home/user/images)
scp -i my-ssh.key test.png user@10.10.72.25:/images/ 

```

### qemu 

```bash
qm shutdown <VMID>  # Graceful
qm stop <VMID>  # Forceful
```

### Redirections

```bash
command >> file  # Add stout
command 2> file  # Put stderr 

#redirecciona stderr hacía donde stdout apunte, y stdout apunta al archivo "file"
command > file 2>&1 # Put stderr or stdout command &> file

comando > salidaok.txt 2> errores.txt

(date ; pwd) > file # Using sub shells

# <<: HERE-DOCUMENT  : Texto interpretado por comando
wc <<end
uno dos tres
cuatro cinco
end

# <<<: HERE-STRNIG  : Interpretado como un argumento(s)
bc <<< 5*5
```

## IP 
```bash
# Give the interface enp0s8
ip a | grep "enp0s8" | grep "inet " | awk '{print $2}' | cut -d/ -f1
ip a | grep "enp0s8" | grep "inet " | sed -E 's/^.*inet ([0-9.]+)\/[0-9]+.*$/\1/'

# Recommended
ip -4 addr show enp0s8 | grep inet | awk '{print $2}' | cut -d/ -f1
```

```bash
ssh usuario@servidor "comando1; comando2 && comando3 || echo 'falló'"
#;: Ejecuta los comandos secuencialmente (aunque uno falle).
#&&: Ejecuta el siguiente comando solo si el anterior tuvo éxito.
#||: Ejecuta el siguiente comando solo si el anterior falló.
```

```bash
# The -n flag ensures that the generated files do not have an extra newline character at the end of the text
echo -n '1f2d1e2e67df' | base64
``` 

```bash
curl -o /dev/null -s -w 'Total: %{time_total}s\n' "link-static-website-s3"

# Create distribution
aws cloudfront create-distribution --origin-domain-name link-static-website-s3 --default-root-object index.html
# List cloudfront distributions
aws cloudfront list-distributions --query "DistributionList.Items[*].{ID:Id,DomainName:DomainName,Origin:Origins.Items[0].DomainName}"

curl "https://dgacknbfyj65z.cloudfront.net/login?user=admin' OR 1=1--"
curl "https://dgacknbfyj65z.cloudfront.net/search?query='; DROP TABLE users;--"
curl "https://cenvul.igp.gob.pe/search?query='; DROP TABLE users;--"
curl "https://dgacknbfyj65z.cloudfront.net/index.php?input=<script>alert('XSS')</script>"
curl -A "GoogleBot" "https://dgacknbfyj65z.cloudfront.net"
```

```bash
nslookup
> instagram.com
> server dnsserver.com # Query to specific dns server
> instagram.com
```