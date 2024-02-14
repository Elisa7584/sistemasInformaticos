#!/bin/bash

# Haz un script que reciba los siguientes argumentos:
# 1 -> Nombre de directorio base
# 2 -> Nombre de fichero para la suma
# 3 -> Nombre de fichero para la media
# 4 y sucesivos -> Lista de números para operar

# El script debe crear el directorio y los ficheros indicados.
# El script debe calcular la suma y la media de todos los números
# y almacenar el resultado en los ficheros correspondientes.

nombreDir=$1
shift
nombreFichSuma=$1
shift
nombreFichMedia=$1
shift

mkdir $nombreDir

sumatorio=0

for numero in $@
do
    sumatorio=$[ $suma + $numero ]
done