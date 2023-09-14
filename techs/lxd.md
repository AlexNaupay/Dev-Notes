lxc list

We can verify information by typing the following commands:
lxc profile list
lxc profile show default
lxc network list
lxc network show [lxdbr0]
lxc storage list
lxc storage show [nixcraftzfs]


Listing built-in LXD image for various Linux distros
lxc image list images:
lxc image list images: | grep -i centos
lxc image list images: | grep -i ubuntu
lxc image list images: | grep -i debian


Creating your first container is straightforward. The syntax is:
lxc launch images:{distro}/{version}/{arch} {container-name-here}
Example:
lxc launch images:alpine/3.13/amd64 alpine-c1
lxc launch images:centos/8/amd64 cenots-8-c2
lxc launch images:debian/stretch/amd64 debian-9-c6
lxc launch images:debian/10/amd64 debian-10-www


List Linux container instances:
lxc list --fast
lxc list | grep RUNNING
lxc list | grep STOPPED
lxc list | grep -i opensuse
lxc list "*c1*"
lxc list "*c2*"
lxc list


We run or execute commands in containers using the exec command as follows:
lxc exec containerName -- command
lxc exec containerName -- /path/to/script
lxc exec containerName --env EDITOR=/usr/bin/vim -- command


How to get the bash shell access in a container:
lxc exec {container-name} {shell-name}
lxc exec debian-10-www bash
lxc exec alpine-c1 sh
lxc exec [lxc_name] -- bash


lxc start|stop|restart {container-name}

lxc delete {container-name}
lxc info {container-name}


Pull a file from the container
lxc file pull {continer-nane}/{path/to/file} {/path/to/local/dest}
lxc file push {/path/to/file} {continer-nane}/path/to/dest/dir/


lxc config set [container_name] limits.memory 512MB
lxc config set [container_name] limits.cpu 2

Troubleshooting
====================================================================================
1.  LXD containers are unable to access the internet while the host has internet connectivity
    Reset firewall profile settings
2. 


Move container to other host
====================================================================================
https://ubuntu.com/blog/lxd-2-0-image-management-512

Turning a container into an image
lxc publish MY_CONTAINER_NAME --alias my-new-image-name

Exporting images
lxc image export MY_NEW_IMAGE_NAME /EXPORTING_PATH.tar.xz

Import image from tarball
lxc image import IMPORTING_IMAGE.tar.gz --alias ALIAS_IMAGE

Lounch from your own image
lxc launch ALIAS_IMAGE NEW_CONTAINER_NAME

