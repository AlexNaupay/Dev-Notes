
```bash
/sbin/iptables-legacy -A INPUT -s 170.106.0.0/24 -j DROP
/sbin/iptables-save
/sbin/iptables-legacy -L 

# On linux to forward, then restart machine or: sysctl --system
# /etc/sysctl.conf
net.ipv4.ip_forward=1 # allows the server to act as a router
```

```bash
# Flush (delete) all rules
iptables -F ; iptables -X ; iptables -t nat -F ; iptables -t nat -X ; iptables -t mangle -F ; iptables -t mangle -X
```
```bash
iptables -S  # List all
iptables -S [INPUT | OUTPUT | TCP]
iptables -L  # Listing rules as tables
iptables -L --line-numbers

# Showing packet counts and aggregate size (bytes)
iptables -L INPUT -v
iptables -Z [INPUT 1]  # Reset for counters

```

