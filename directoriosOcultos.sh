#!/bin/bash
#Francisco Bayo & Elisa Ortega
NOMBREDIR=$1
VISIBILIDAD=$2
OBJETOACREAR=$3
CANTIDAD=$4

if [ $# -eq 4 ] && [ $CANTIDAD -ge 1 ] && [ $CANTIDAD -le 100 ];
then
    if ! test -t $NOMBREDIR 
    then
        if [ $VISIBILIDAD == '-o' ];
        then
            echo 'es oculto'
            mkdir .$NOMBREDIR
            NOMBREDIR=.$NOMBREDIR
        elif [ $VISIBILIDAD == '-v' ];
        then
            echo 'es visible'
            mkdir $NOMBREDIR
        fi
    else
        if [ $VISIBILIDAD == '-o' ];
        then
            echo 'es oculto'
            mv $NOMBREDIR .$NOMBREDIR
            NOMBREDIR=.$NOMBREDIR
        elif [ $VISIBILIDAD == '-v' ];
        then
            echo 'es visible'
            mv .$NOMBREDIR $NOMBREDIR
        fi
    fi

    if [ $OBJETOACREAR == '-f' ];
    then
        for ((i=1;i<=$CANTIDAD;i++)); do
            touch $NOMBREDIR/file_$NOMBREDIR$i.txt
            done
    elif [ $OBJETOACREAR == '-d' ];
    then
        for ((i=1;i<=$CANTIDAD;i++)); do
            mkdir $NOMBREDIR/dir_$NOMBREDIR$i
            done
        fi
fi
