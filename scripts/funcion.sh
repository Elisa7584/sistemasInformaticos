restar(){
    numero1=$1
    numero2=$2

    echo $[ $numero1 - $numero2 ]
}

restar 2 2

resultado=`restar 2 2`

echo $resultado