## Docker utils
```bash
# allow, deny, reject, limit 
ufw default allow outgoing
ufw default deny incoming

# ufw app list
ufw allow ssh|22
ufw allow from 127.0.0.1 to any port 80,443
ufw allow proto tcp from any|IP to any port 80,443
ufw allow proto tcp from any|IP to any port 22

ufw allow from 203.0.113.4

# Range
ufw allow 6000:6007/tcp
ufw allow from 203.0.113.0/24
ufw allow from 203.0.113.0/24 to any port 22

# Interfaces
ufw allow in on eth0 to any port 80

ufw deny http
ufw deny from 203.0.113.4

# outgoing
ufw deny out 25  # outbound connections to port 25
ufw allow out to 172.18.0.0/16  # outgoing connections to 172.18.0.0/16
ufw allow out to 192.168.18.61 port 8080
ufw allow out proto tcp to 127.0.0.1 port 8080,3000,9001,8090

ufw delete 2
ufw delete allow http

ufw show added
ufw enable
ufw status verbose
ufw status numbered
ufw disable

ufw reset  # you want to start over
```