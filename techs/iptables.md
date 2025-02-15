
```bash
/sbin/iptables-legacy -A INPUT -s 170.106.0.0/24 -j DROP
/sbin/iptables-save
/sbin/iptables-legacy -L 

# On linux to forward, then restart machine
# /etc/sysctl.conf
net.ipv4.ip_forward=1
```
