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

### Colorize nginx log

`tail -f  /var/log/nginx/access.log | ccze -A |grep /some-filers/`