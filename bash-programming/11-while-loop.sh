#!/bin/bash
# Programa para ejemplificar el uso de la sentencia de iteración for

my_dir="$(dirname "$0")"
. "$my_dir/colors.sh"

function iterarListaNumeros   {
  arregloNumeros=(1 2 3 4 5 6)
  echo "Iterar en la Lista de Números"
  for num in ${arregloNumeros[*]}
  do
      echo "Número: $num"
  done
}

function iterarCadena {

  echo "Iterar en la lista de Cadenas"
  for nom in "Marco" "Pedro" "Luis" "Daniela"
  do
    echo "Nombre : $nom"
  done
}

function iterarArchivos {
  counter=0
  echo "Iterar en Archivos"
  for fil in *
  do
      echo "File $counter: $fil"
      ((counter+=1))
  done
}

function iterarComando {
  counter=1
  echo "Iterar utilizando un comando"
  for fil in $(ls *.sh)
  do
      echo "File $counter: $fil"
      counter=$((counter+1))
  done
}

function iteracionTradicional {
  echo "Iterar utilizando el formato tradcional"

  for ((i=1; i<4; i++))
  do
      echo "Number: $i"
  done
}

option=1

while [[ $option -ge 1 ]] && [[ $option -le 5 ]]
do
  clear
  echo -e "${BBlue}Choose an option
    1 - Iterar lista de numeros
    2 - Iterar lista de cadenas
    3 - Iterar en Archivos
    4 - Iterar utilizando comando
    5 - Iteracion tradicional
    * - Salir ${NC}"

  read -r -n1 -p "Your option:" option
  echo -e "\n"

  if [[ $option =~ ^[1-5]$ ]]; then
      echo -e "${Green}Valid option${NC}"
  fi

  case $option in
    1) iterarListaNumeros ;;
    2) iterarCadena ;;
    3) iterarArchivos ;;
    4) iterarComando ;;
    5) iteracionTradicional;;
    *) echo -e "${Red}Unknown option${NC}";;
  esac
  sleep 5
done

#while [ conditions ]
#do
# // Instructions
#done