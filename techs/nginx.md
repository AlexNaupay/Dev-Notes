### goaccess

[https://github.com/allinurl/goaccess](https://github.com/allinurl/goaccess)

```bash
goaccess access.log -a --log-format=COMBINED --date-format=%d/%b/%Y --time-format=%T -o report.html
```

### nginx macos
```bash
# rewrite ^/servicios/mpv/(.*)$ /servicios/mesa-partes-virtual/$1 redirect;

# MacOS nginx config
# /Library/Application Support/Herd/config/nginx
cd Library/Application\ Support/Herd/config/nginx
Add path to *.conf on /Library/Application Support/Herd/config/nginx/nginx.conf
# /opt/homebrew/etc/nginx/servers

# sudo nginx -s reload
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