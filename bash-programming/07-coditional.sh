#! /bin/bash
# Los operadores lógicos estándar (>, <, etc.) se usan para comparación lexicográfica de cadenas
#
# Para comparar números se usan los operadores:
# 	-eq: Igual a
# 	-ne: Diferente a
# 	-gt: Mayor que
# 	-ge: Mayor o igual que
# 	-lt: Menor que
# 	-le: Menor o igual que
#
# [[]] tiene más características que [] (como manejo de expresiones regulares y otros operadores de validación)
#
# (()) es para validaciones aritméticas (sólo números implicados; preferible en especial cuando hay operaciones
# aritméticas). Usa los operadores lógicos estándar.


age=$1
job="Eng"

if (( age > 18 )) && [[ $job == "Eng" ]]; then
  echo "You are Alex"
else
  echo "You are not Alex"
fi

if [ "$age" -gt 18 ] && [[ $job == "Eng" ]]; then
  echo "You are Alex"
else
  echo "You are not Alex"
fi

if [[ $age -gt 18 ]] && [[ $job == "Eng" ]]; then
  echo "You are Alex"
else
  echo "You are not Alex"
fi

# [ STRING1 != STRING2 ] --> True if the strings are not equal.
# [ STRING1 < STRING2 ] --> True if "STRING1" sorts before "STRING2" lexicographically in the current locale.
# [ STRING1 > STRING2 ] --> True if "STRING1" sorts after "STRING2" lexicographically in the current locale.
# [ -a FILE ] --> True if FILE exists.
# [ -b FILE ] --> True if FILE exists and is a block-special file.
# [ -c FILE ] --> True if FILE exists and is a character-special file.
# [ -d FILE ] --> True if FILE exists and is a directory.
# [ -e FILE ] --> True if FILE exists.
# [ -f FILE ] --> True if FILE exists and is a regular file.
# [ -g FILE ] --> True if FILE exists and its SGID bit is set.
# [ -h FILE ] --> True if FILE exists and is a symbolic link.
# [ -k FILE ] --> True if FILE exists and its sticky bit is set.
# [ -p FILE ] --> True if FILE exists and is a named pipe (FIFO).
# [ -r FILE ] --> True if FILE exists and is readable.
# [ -s FILE ] --> True if FILE exists and has a size greater than zero.
# [ -t FD ] --> True if file descriptor FD is open and refers to a terminal.
# [ -u FILE ] --> True if FILE exists and its SUID (set user ID) bit is set.
# [ -w FILE ] --> True if FILE exists and is writable.
# [ -x FILE ] --> True if FILE exists and is executable.
# [ -O FILE ] --> True if FILE exists and is owned by the effective user ID.
# [ -G FILE ] --> True if FILE exists and is owned by the effective group ID.
# [ -L FILE ] --> True if FILE exists and is a symbolic link.
# [ -N FILE ] --> True if FILE exists and has been modified since it was last read.
# [ -S FILE ] --> True if FILE exists and is a socket.
#
# [ FILE1 -nt FILE2 ] --> True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
# [ FILE1 -ot FILE2 ] --> True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
# [ FILE1 -ef FILE2 ] --> True if FILE1 and FILE2 refer to the same device and inode numbers.
# [ -o OPTIONNAME ] --> True if shell option "OPTIONNAME" is enabled.
#
# [ -z STRING ] --> True of the length if "STRING" is zero.
# [ -n STRING ] or [ STRING ] --> True if the length of "STRING" is non-zero.
# [ ARG1 OP ARG2 ] --> "OP" is one of -eq, -ne, -lt, -le, -gt or -ge. "ARG1" and "ARG2" are integers.

read -r -t 2 -p "Enter a yes or not in 5 secs: " answer

if [ -z "$answer" ]; then
    echo -e "\nEmpty answer"
fi

if [ -n "$answer" ]; then
    echo "Great you answered"
else
  echo "No answers"
fi

# Strings
if [ 0001 == 1 ]; then
    echo "same String"
fi

# Numbers
if [ "0001" -eq 1 ]; then
    echo "Same Numbers"
fi

if [ -d "/Users/alexh/Desktop" ]; then
    echo "Dir exists"
fi