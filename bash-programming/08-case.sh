#!/bin/bash

read -r -n1 -p "Enter an option: [A-Z]: " option
echo -e "\n"

case $option in
  A) echo "Option is A";;
  "B") echo "Option is B";;
  [C-Z]) echo "Option is from C to Z";;
  *) echo "No valid option!";;

esac