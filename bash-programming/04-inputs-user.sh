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
