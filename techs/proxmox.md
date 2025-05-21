## Export backup .vma as .vdi
click the Backup Now option. Set the target location to None, Mode to Stop, and Compression to None > Back up the data

## Export backup .vma as .vdi
- Using the vma command line tool, extract the.vma file.

    `vma extract -v vzdump-filename.vma DESTINATION_DIRECTORY_TO_CREATE`

- Wait for the.vma to be extracted, which will result in a.raw disk image.
- Covert raw to .vdi with qemu

    `qemu-img convert -f raw -O vdi RAW_PATH.raw VDI_PATH.vdi`


# Install qemu-guest-agent on vm

```bash
apt install qemu-guest-agent
systemctl start qemu-guest-agent
systemctl enable qemu-guest-agent
```


WARNING: Device /dev/dm-42 not initialized in udev database even after waiting 10000000 microseconds.
Disk not found
```bash
udevadm trigger
```

### qemu 

```bash
qm shutdown <VMID>  # Graceful
qm stop <VMID>  # Forceful
```

## Restore from backup file 

```bash
# VM
qmrestore <backup-file> <new-vm-id> [options]
qmrestore vzdump-qemu-140-2024_09_24-12_09_39.vma.zst 140
qmrestore vzdump-qemu-140-2024_09_24-12_09_39.vma.zst 140 --unique  # Modify network interfaces and disks to be unique

# Container
pct restore <new-container-id> <backup-file> [options]
pct restore 104 vzdump-lxc-107-2025_05_21-11_26_57.tar.zst --storage local-lvm
```

## Rename storage

```bash
# /etc/pve/storage.cfg
# https://youtu.be/3YDPNn0FsVo?si=-RJ3RIL7wkrgvb5p&t=492
```