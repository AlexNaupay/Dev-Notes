#! /bin/bash
# Programa para ejemplificar cómo se lee en un archivo

echo "Leer en un archivo"

#Primer método
echo "========================================"
echo -e "\nLeer directamente todo el archivo"
cat $1

#Segundo método
echo "========================================"
echo -e "\nAlmacenar los valores en una variable"
valorCat=$(cat "$1")
echo "$valorCat"

#Tercer método
#Se utiliza la variable especial IFS (Internal File Separator) para evitar que los espacios en blanco se recorten
echo "========================================"
echo -e "\nLeer archivos línea por línea utilizando while"

while IFS= read linea
do
    echo "$linea"
done < $1