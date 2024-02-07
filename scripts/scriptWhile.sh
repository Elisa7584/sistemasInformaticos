#!/bin/bash

nombre=0

while true;
do 
    ls /bin > $nombre
    nombre=$[ $nombre * 1 ]
done