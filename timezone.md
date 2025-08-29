## set timezone as EST:

sudo timedatectl set-timezone EST
timedatectl set-timezone America/Lima
## set timezone as UTC:

sudo timedatectl set-timezone UTC

## list all timezones:

timedatectl list-timezones

## Change hardware clock (BIOS)
    date -s "2023-01-31 15:05:10"
    hwclock --systohc
    hwclock -r
