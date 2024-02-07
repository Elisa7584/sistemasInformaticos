#!/bin/bash

if [$# -eq 3] && [$2 -ge 1] && [$2 -le 99]; 
then
    dirname="$1"
    num_files="$2"
    basefilename="$3"

    #El test comprueba si existe / COMPRUEBA SI NO ES UN DIRECTORIO

    if ! test -d $dirname
    then    
        mkdir $dirname
    fi

    for  ((i=1 ; i<=$num_files ; i++))
    do
        touch $dirname/$basefilename$i.txt
    done

fi

# TIPOS DE COMPRADORES

# -eq  -> Equals (equivale / ==)

# -gt  -> Greater than (mayor que / >)
# -ge  -> Greater or equal than (mayor o igual que / >=)

# -lt  -> Less than (menor que / <)
# -le  -> Less or equal than (menor o igual que / <=)

# TIPO DE COMPROBACION DE ARCHIVOS

# test -d (directory / directorio) - ¿Es un directorio?
# Si pones ! test -d  estas comprobando si NO lo es, lo estas negando

# touch -> Crea un fichero vacio