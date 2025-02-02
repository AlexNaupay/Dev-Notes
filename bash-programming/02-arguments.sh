#!/bin/bash

# $_	Asigna la variable al último argumento del último comando
# $?	Muestra el código de estado de salida para el último comando ejecutado

echo "PID: $$"
echo "Filename: $0"
echo "Arg 1: $1"
echo "last me"
echo "Last arg?: $_"
echo "Flags: $-"
echo "Arg 10: ${10}"
echo "Count args: $#"
echo "All args: $*"
echo "All args array: $@"
echo "Result of last command: $?" # 0: success; !=0: No success
