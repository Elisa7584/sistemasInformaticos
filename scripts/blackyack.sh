#!/bin/bash
# HAZ UN SCRIPT QUE SUME CARTAS DE BLACKJACK
# 1 -> 11
# 2 -> 2
# 3 -> 3
# 4 -> 4
# 5 -> 5
# 6 -> 6
# 7 -> 7
# 8 -> 8
# 9 -> 9
# 10 -> 10
# 11 -> 10
# 12 -> 10
# 13 -> 10
# VALORES FUERA DE RANGO NO SE TIENEN EN CUENTA

echo "Hay $# cartas"

suma=0

for carta in $@
do
    if [ $carta -eq 1 ];then
        suma=$ [ suma + 11 ]
    elif [ $carta -eq 10 || $carta -eq 11 || $carta -eq 12 || $carta -eq 13 ]; then
        suma=$ [ suma + 10 ]
    elif [ $carta -ge 2 || $carta -le 9 ]; then
        suma=$ [ suma + $carta ]
    fi
done

