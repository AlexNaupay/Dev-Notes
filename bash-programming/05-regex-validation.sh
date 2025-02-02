#!/bin/bash

ID_REGEX='^[0-9]{8}$'
COUNTRY_REGEX='^EC|PE|COL|US$'
BORN_REGEX='^(19|20)([0-9]{2})-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$'

read -r -n 8 -p "Your ID: " id
echo -e ""
read -r -t 5 -p "Country (PE): " country
echo -e ""
read -r -p "Birth date (yyyy-mm-dd): " date
read -r -s -p "Password: " password

if [[ $country = '' ]]; then
    country='PE'
fi

if [[ $id =~ $ID_REGEX ]]; then
    echo "Valid ID"
else
    echo "ID not valid"
fi 

if [[ $country =~ $COUNTRY_REGEX ]]; then
    echo "Valid Country"
else
    echo "Country not valid"
fi 

if [[ $date =~ $BORN_REGEX ]]; then
    echo "Valid Birth"
else
    echo "Birth day not valid"
fi 
