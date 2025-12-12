## set timezone as EST:

sudo timedatectl set-timezone EST
timedatectl set-timezone America/Lima
## set timezone as UTC:

sudo timedatectl set-timezone UTC

## list all timezones:

timedatectl list-timezones

## Legacy but it works
`dpkg-reconfigure tzdata`

## Change hardware clock (BIOS)
```bash
date -s "2023-01-31 15:05:10"  # Set symtem clock
hwclock --systohc  # Sync RTC ← from system clock
hwclock -r

#Sync System Clock → from RTC
hwclock --hctosys
```

## Force sync clock
```bash
timedatectl set-ntp false # then
timedatectl set-ntp true
# Check the status after a minute or two to see if it synchronized
timedatectl
```

## NTP server configuration
```bash
nano /etc/systemd/timesyncd.conf
# Uncomment the NTP= line and add some reliable NTP servers
systemctl restart systemd-timesyncd
# Check the status with timedatectl after a minute
timedatectl
```