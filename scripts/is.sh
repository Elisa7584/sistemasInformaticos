#!/bin/bash

nombreEquipo=$1
deportePracticado=$2
jugadores=("${@:3}")  # Almacena todos los argumentos a partir del tercero en un array

# Verifica si el deporte practicado es válido
if [ ! "$deportePracticado" == "futbol" ] && [ ! "$deportePracticado" == "baloncesto" ] && [ ! "$deportePracticado" == "voleibol" ]; then
    echo "Error, deporte no válido. Los deportes válidos son futbol, baloncesto o voleibol."
    exit 1
fi

# Verifica la cantidad de jugadores
case "$deportePracticado" in
    futbol)
        if [ ${#jugadores[@]} -ne 11 ]; then
            echo "Error, se esperaban 11 jugadores para el futbol."
            exit 1
        ;;
    baloncesto)
        if [ ${#jugadores[@]} -ne 5 ]; then
            echo "Error
