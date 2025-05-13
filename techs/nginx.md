### goaccess

[https://github.com/allinurl/goaccess](https://github.com/allinurl/goaccess)

```bash
goaccess access.log -a --log-format=COMBINED --date-format=%d/%b/%Y --time-format=%T -o report.html
```

### nginx macos
```bash
# rewrite ^/servicios/mpv/(.*)$ /servicios/mesa-partes-virtual/$1 redirect;

# MacOS herd
# /Library/Application Support/Herd/config/nginx
cd Library/Application\ Support/Herd/config/nginx
Add path to *.conf on /Library/Application Support/Herd/config/nginx/nginx.conf
herd restart
```

### nginx OS

```bash
brew install nginx
brew services start nginx  # Servicio en segundo plano (incluso se ejecutará al iniciar tu Mac)
brew services stop nginx
brew services restart nginx
brew services list | grep nginx

# Manualmente
sudo nginx -help
nginx -v
sudo nginx # start
sudo nginx -s stop
sudo nginx -s reload
sudo nginx -t

# Files
/opt/homebrew/etc/nginx/nginx.conf  # config
/opt/homebrew/etc/nginx/servers/  # servers
/opt/homebrew/var/log/nginx/  # logs
/opt/homebrew/var/www/  # root of sites 
```

### Colorize nginx log

https://lnav.org/features

`tail -f  /var/log/nginx/access.log | ccze -A |grep /some-filers/`

### Custom log format
```sh
http {
    ...
    log_format custom_access '$remote_addr - $gip2_country_code [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"';
    log_format custom_access '$remote_addr - $remote_user [$time_iso8601] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"';
    ...

    access_log /var/log/nginx/access.log custom_access;
}
```

### GeoIP module
```sh
# This legacy database
apt install libnginx-mod-http-geoip geoip-database
nginx -V 2>&1 | grep --color geoip

# Carefully 
https://www.miyuru.lk/geoiplegacy
wget -q -O- https://dl.miyuru.lk/geoip/maxmind/country/maxmind.dat.gz | gunzip -c > /etc/nginx/maxmind-country.dat; \
wget -q -O- https://dl.miyuru.lk/geoip/maxmind/city/maxmind.dat.gz | gunzip -c > /etc/nginx/maxmind-city.dat; \

# Add if needed in /etc/nginx/nginx.conf 
# load_module modules/ngx_http_geoip_module.so;

http {
    geoip_country /usr/share/GeoIP/GeoIP.dat;
    geoip_city /usr/share/GeoIP/GeoLiteCity.dat;

    # Optional: set a variable for logging or headers
    geoip_proxy 0.0.0.0/0;

    log_format geo '$remote_addr - $geoip_country_code $geoip_city';

    access_log /var/log/nginx/access.log geo;

    ...
    map $geoip_country_code3 $from_peru {
        default no;
        PER     yes;
    }

    if ($from_peru = yes){
        return 301 https://mysite.com/pe
    }

    if ($from_peru = no){
        return 301 https://mysite.com/
    }
    ...

    server {
        location / {
            add_header X-Country-Code $geoip_country_code;
        }
    }
}

# Available variables
$geoip_country_code
$geoip_country_code3
$geoip_country_name

# city.dat
$geoip_city_continent_code
$geoip_latitude
$geoip_longitude
$geoip_region
$geoip_city
```


### GeoIP2 module
```bash
apt update
apt install nginx libnginx-mod-http-geoip2

mkdir -p /etc/nginx/geoip2
cd /etc/nginx/geoip2

# Country database 
wget "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=YOUR_LICENSE_KEY&suffix=tar.gz" -O GeoLite2-Country.tar.gz
wget "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=YOUR_LICENSE_KEY&suffix=tar.gz" -O GeoLite2-City.tar.gz
tar --strip-components=1 -xzf GeoLite2-Country.tar.gz
tar --strip-components=1 -xzf GeoLite2-City.tar.gz

nano /etc/nginx/nginx.conf
load_module modules/ngx_http_geoip2_module.so;

# Inside the http { ... }
# Enabling auto reload will have nginx check the modification time of the database at the specified interval and reload it if it has changed.
geoip2 /etc/nginx/geoip2/GeoLite2-Country.mmdb {
    # auto_reload 72h | 5m | 30s;
    auto_reload 12h;
    $geoip2_country_code default=XX country iso_code;
    $geoip2_country_name country names en;
}

geoip2 /etc/nginx/geoip2/GeoLite2-City.mmdb {
    auto_reload 12h;
    $geoip2_city_name city names en;

    # $geoip2_region_code subdivisions 0 iso_code;
    # LMA
    # $geoip2_region_name subdivisions 0 names en;
    # Lima Province

    # $geoip2_latitude location latitude;
    # $geoip2_longitude location longitude;
    # $geoip2_timezone location time_zone;
    # America/Lima
}

log_format geoip '$remote_addr - $geoip2_country_code $geoip2_country_name - $geoip2_city_name';
access_log /var/log/nginx/access.log geoip;

# Available variables

```

#### Install maxmind packages DB on: /usr/share/GeoIP/
```bash
# https://dev.maxmind.com/geoip/updating-databases/
# https://github.com/maxmind/geoipupdate

# GeoIP.conf file - used by geoipupdate program to update databases
# from http://www.maxmind.com
# /etc/GeoIp.conf
AccountID YOUR_ACCOUNT_ID_HERE
LicenseKey YOUR_LICENSE_KEY_HERE
EditionIDs YOUR_EDITION_IDS_HERE
# EditionIDs GeoLite2-ASN GeoLite2-City GeoLite2-Country

#### Ubuntu
# Config: /etc/GeoIp.conf
add-apt-repository ppa:maxmind/ppa
# Install dbs on /usr/share/GeoIP/ and geoipupdate
apt install geoipupdate libmaxminddb0 libmaxminddb-dev mmdb-bin

#### Debian 1 : Config: /etc/GeoIp.conf
wget https://github.com/maxmind/geoipupdate/releases/download/v7.1.0/geoipupdate_7.1.0_linux_amd64.deb
dpkg -i geoipupdate_7.1.0_linux_amd64.deb

### Debian 2 : # Config: /usr/local/etc/GeoIP.conf
wget https://github.com/maxmind/geoipupdate/releases/download/v7.1.0/geoipupdate_7.1.0_linux_amd64.tar.gz -O  geoipupdate.tar.gz
tar zfx geoipupdate.tar.gz
cp geoipupdate/geoipupdate /usr/local/bin/


# Test DB
apt install mmdb-bin
mmdblookup --file /usr/share/GeoIP/GeoLite2-Country.mmdb --ip 8.8.8.8

# https://crontab.guru/examples.html
0 0 * * 0 /usr/bin/geoipupdate  # Sundays at 0
@weekly /usr/bin/geoipupdate  # Sundays at 0

```