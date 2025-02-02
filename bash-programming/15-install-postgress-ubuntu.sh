#!/bin/bash
#Programa que permite manejar las utilidades de Postgres
#Autor: Juan Manuel

opcion=0
fechaActual=`date +%Y%m%d`

#Función para instalar postgres
instalar_postgres () {
    echo -e "\nVerificar instalación de Postgres"
    verifyInstall=$(wich psql)
    if [[ $? -eq 0 ]]; then
        echo "Postgres ya se encuentra instalado"
    else
        read -s -p "Ingresar contraseña de sudo: " password
        read -s -p "Ingresar contrseña a utilizar en postgres: " passwordPostgres
        echo "$password" | sudo -S apt aptupdate
        echo "$password" | sudo -S apt-get -y install postgresql postgresql-contrib
        sudo -U postgres psql -c "ALTER USER postgres WITH PASSWORD '{passwordPostgres}';"
        echo "$password" | sudo -S systemctl enable postgresql.service
        echo "$password" | sudo -S systemctl start postgresql.service
    fi
    read -n1 -s -r -p "Presione una tecla para continuar..."
}

#Función para desinstalar postgres
desinstalar_postgres () {
    echo "Desinstalar postgres..."
    read -s -p "Ingresar contraseña de sudo: " password
    echo -e "\n"
    read -s -p "Ingresar contrseña a utilizar en postgres: " passwordPostgres
    echo "$password" | sudo -S systemctl stop postgresql.service
    echo "$password" | sudo -S apt-get -y --purge postgresql\*
    echo "$password" | sudo -S rm -r /etc/postgresql
    echo "$password" | sudo -S rm -r /etc/postgresql-common
    echo "$password" | sudo -S rm -r /var/lib/postgresql
    echo "$password" | sudo -S userdel -r postgres
    echo "$password" | sudo -S groupdel postgresql
    read -n1 -s -r -p "Presione una tecla para continuar..."
}


#Función para sacar respaldo
sacar_respaldo () {
    echo "Listar bases de datos postgres"
      sudo -u postgres psql -c "\l"
      read -p "Elegir la base de datos a respaldar" DBdump
      echo -e "\n"
      if [ -d "$1" ]; then
        echo "Establecer permisos de directorio"
        read -p -s "Ingresar contraseña ROOT: "password
        echo "$password" | sudo -S chmod 755 $1
        echo "sacando respaldo.."
        sudo -u postgres pg_dump -Fc $DBdump > "$1/$DBdump$fechaActual.bak"
        echo "Respaldo realizado en $1/$DBdump$fechaActual.bak"
      else
        read -p -n 1 "El directorio $1 no existe, desea crearlo s/n?" crerdirectorio
        if [ $crerdirectorio = "s" ]; then
          mkdir $1
          [ $? -eq 0 ] && echo "Directorio creado con exito. Vuelva a ingresar para realizar respaldo" || echo "error %?"
        fi
      fi
      read -n 1 -s -r -p "PRESIONE [ENTER] para continuar..."
}

#Función para restaurar respaldo
restaurar_respaldo () {
    echo "Listar Backups"
      ls -1 $1/*.bak
      read -p "Elegir el Backup a Restaurar: " backupRestore
      read -p $'\nIngrese el nombre de la BDD destino: ' bddDestino
      #Verificar si la BDD existe!
      verifyBdd=$(sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -wq $bddDestino)
      if [ $? -eq 0 ]; then
        echo "Restaurando en la BDD destino: $bddDestino"
      else
        sudo -u postgres psql -c "create database $bddDestino"
      fi
      #Verificar si el respaldo que se va restaurar existe
      if [ -f "$1/$backupRestore" ]; then
        echo "Restaurando Backup..."
        sudo -u postgres pg_restore -Fc -d $bddDestino "$1/$backupRestore"
        echo -e "\nListar la BDD"
        sudo -u postgres psql -c "\l"
      else
        echo -e "\nEl Backup $backupRestore no existe!"
      fi
      read -n1 -s -r -p $'\nPresione [ENTER] para continuar'
}

while :
do
    #Limpiar la pantalla
    clear
    #Desplegar el menu de opciones
    echo "_________________________________________"
    echo "PGUTIL - Programa de Utilidad de Postgres"
    echo "-----------------------------------------"
    echo "            MENÚ PRINCIAPAL              "
    echo "-----------------------------------------"
    echo "1. Instalar Postgres"
    echo "2. Desinstalar Postgres"
    echo "3. Sacar un respaldo"
    echo "4. Restaurar respaldo"
    echo "5. Salir"

    #Leer los datos del usuario
    read -n1 -p "Ingrese una opción (1-5): " opcion

    #Validación
    case $opcion in
        1)
            instalar_postgres
            sleep 3
            ;;
        2)
            desinstalar_postgres
            sleep 3
            ;;
        3)
            read -p "Directorio de Backup: " directorioBackup
            sacar_respaldo $directorioBackup
            sleep 3
            ;;
        4)
            read -p "Direcotrio de Respaldos: " direcotrioRespaldos
            restaurar_respaldo $directorioRespaldos
            sleep 3
            ;;
        5)
            echo -e "\nSaliendo del prgorama"
            exit 0
            ;;
    esac
done