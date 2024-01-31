## change mod for all files --recursive
    find <DIR|.> -type f -exec chmod 644 {} +

##  change files and directories recursively
    chmod -R 755 ./**

## recursive list 
    ls -R

## que archivos son diferentes
    diff --brief -r dir1/ dir2/

## Replace text 
    sed -i 's/old_string/new_string/g' *
    sed -i 's/UtilsService.log/sails.log.debug/g' * 

## ver conexiones ssh a host
    netstat -ap | grep 'ESTABLISHED.*ssh'
   
## ver puertos, etc en uso 
    sudo netstat -tulpn

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


