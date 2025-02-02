#!/bin/bash

# $_	Asigna la variable al último argumento del último comando
# $?	Muestra el código de estado de salida para el último comando ejecutado

# Ubuntu
# [ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

if [ "$USER" != 'root' ]; then
	echo "Your not a root user"
	read -r -s -p "Enter root password:" password
	echo "$password" | su -c "apt update"
fi

if [ "$USER" != 'root' ]; then
        echo "Your not a root user"
        read -r -s -p "Enter root password:" password
        echo "$password" | su -c "which git && echo 'Git is installed'  || (echo 'Git is not installed' && apt update && apt install -y git)"
fi

# Check exit code directly with e.g. if mycmd;, not indirectly with $?.

if ! which git
then
  echo "Git is not installed!!!"
fi

if which git
then
  echo "GIT INSTALLED"
fi

isGit=$(which git)

if [[ $? -eq 0 ]]; then
        echo "Git is installed"
fi

if [ -n "$isGit" ]; then
        echo "Git is installed ... cool"
fi

echo "$isGit"

if [ -z "$isGit" ]; then
if [ "$USER" != 'root' ]; then
        echo "Your not a root user"
        read -r -s -p "Enter root password:" password
        echo "$password" | su -c "which git && echo 'Git is installed'  || (echo 'Git is not installed' && apt update && apt install -y git)"
fi
fi

