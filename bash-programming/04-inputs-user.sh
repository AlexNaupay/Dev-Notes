#!/bin/bash

echo "Tell me your answer:"
read answer
echo "Your answer was: $answer"

echo -n "Your Age:"
read
age=$REPLY

echo -n "Name:"
read
name=$REPLY

echo "Answers: $age, $name"


echo "------------------------------"
read -p "Name with read: " name2
read -p "Age with read: " age2
echo "$name2, $age2"

# Reading with timeout:
read -t 10 -p "Enter your answer (10 sec timeout): " answer
if [ -z "$answer" ]; then
    echo "Time's up!"
else
    echo "You answered: $answer"
fi

# Silent Input (for passwords)
read -s -p "Enter your password: " password
echo
echo "Password received (but not displaying for security)"

# Using default values
read -p "Enter your country [default: USA]: " country
country=${country:-USA}
echo "Country: $country"