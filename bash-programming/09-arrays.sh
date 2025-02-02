#!/bin/bash
#Programa para ejemplificar el uso de los arreglos

arregloNumeros=(1 2 3 4 5 6)
arregloCadenas=(Alex "Ramón" Antonio Junior Pablo)
arregloRangos=({A..Z} {10..20})

#Imprimir todos los valores
echo "All values ******"
echo "Arreglo de Números: ${arregloNumeros[*]}"
echo "Arreglo de Cadenas: ${arregloCadenas[*]}"
echo "Arreglo de Rangos: ${arregloRangos[*]}"

#Imprimir los tamaños de los arreglos
echo -e "Sizes ******"
echo "Tamaño arreglo de Números: ${#arregloNumeros[*]}"
echo "Tamaño arreglo de Cadenas: ${#arregloCadenas[*]}"
echo "Tamaño arreglo de Rangos: ${#arregloRangos[*]}"

#Imprimir la posición 3 del arreglo de Números, Cadenas y Rangos
echo -e "4th ******"
echo "Posición 3 arreglo de Números: ${arregloNumeros[3]}"
echo "Posición 3 arreglo de Cadenas: ${arregloCadenas[3]}"
echo "Posición 3 arreglo de Rangos: ${arregloRangos[3]}"

#Añadir Eliminar valores de un arreglo
echo -e "=================== set and remove"
arregloNumeros[6]=20
arregloNumeros[2]=50
unset arregloNumeros[0]
echo "Arreglo de Números: ${arregloNumeros[*]}"
echo "Tamaño del Arreglo de Números ${#arregloNumeros[*]}"