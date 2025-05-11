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

`tail -f  /var/log/nginx/access.log | ccze -A |grep /some-filers/`

### Custom log format
```sh
http {
    ...
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