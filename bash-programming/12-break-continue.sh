#!/bin/bash
# Programa para ejemplificar el uso de break y continue
my_dir="$(dirname "$0")"
. "$my_dir/colors.sh"

echo "Sentencias de Break y continue"
for fil in $(ls *.sh)
do
    for nombre in {1..4}
    do
        if [ "$fil" = "02-arguments.sh" ]; then
          echo -e "${Red}Break ....${NC}"
          break;
        elif [[ $fil == 10* ]]; then # size?
          echo -e "${Purple}Continue ....${NC}"
          continue;
        else
            echo "Nombre Archivo: $fil _ $nombre"
        fi
    done
done