#!/bin/bash
# Programa para ejemplificar como se realiza el paso de opciones con o sin parámetros

echo "Programa opciones"
echo "Opción 1 enviada: $1"
echo "Opción 2 enviada: $2"
echo "Opción 3 enviada: $3"
echo "Opciones enviadas: $*"
echo -e "\n"

echo "Recuperar valores"
echo "-----------------"
while [ -n "$1" ]
    do
      echo "All options: $*"
      echo "All options count: $#"
      case "$1" in
      -a) echo "-a Option used ";;
      -b) echo "-b Option used ";;
      -c) echo "-c Option used ";;
      *) echo "$1 no es una opción";;

      esac
      shift
      echo "---"
    done

# https://www.shellscript.sh/examples/getopts/