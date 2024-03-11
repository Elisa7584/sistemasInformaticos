#!/bin/bash

#PROYECTO INICIAL
palabra=$1
shift

pid=$4
arg=$3
gid=$2

easterEgg1=("R1" "R2" "L1" "X" "izquierda" "abajo" "derecha" "arriba" "izquierda" "abajo" "derecha" "arriba")
easterEgg2=("R1" "R1" "círculo" "R2" "arriba" "abajo" "arriba" "abajo" "arriba" "abajo")

# Ejemplo de string aleatorio 

# nombre_random_1() {
#     easterEgg3=("R1" "R2" "L1" "X" "izquierda")
#     random_index=$(( $RANDOM % ${#easterEgg3[@]}))
#     echo "${easterEgg3[$random_index]}"
# }

CreacionGrupos() {
    if [ $# -eq 1 ]; then
        nomGrup=$1
        sudo groupadd $nomGrup
    elif [ $# -gt 1 ]; then
        nomGrup=$1
        gid=$2
        sudo groupadd -g $gid $nomGrup
    fi
}

EliminarGrupos() {
    nomGrupo=$1
    sudo delgroup --only-if-empty $nomGrupo
}

CreacionUsuarios(){
    if [ $# -eq 2 ]; then
        nomUsu=$1
        grupPrincipal=$2
        contrasenia=$(( $RANDOM % (999999 - 100000 + 1) + 100000 ))
        sudo useradd -m -g $grupPrincipal -p $contrasenia  -s /bin/bash $nomUsu
        echo "El usuario $nomUsu ha sido creado y su contraseña es $contrasenia"
    elif [ $# -gt 2 ]; then
        # Utilizo el shift para poder guardar todos los grupos secundarios al final en una sola variable con el $@
        nomUsu=$1
        shift
        grupPrincipal=$1
        shift
        grupoSecundarios=$@
        contrasenia=$(( $RANDOM % (999999 - 100000 + 1) + 100000 ))
        sudo useradd -m -g $grupPrincipal -G $grupoSecundarios -p $contrasenia  -s /bin/bash $nomUsu
        echo "El usuario $nomUsu ha sido creado y su contraseña es $contrasenia"
    fi
}

EliminarUsuarios(){
    nomUsuario=$1
    sudo deluser --remove-home $nomUsuario
}

manual() {
    echo "Uso de los argumentos al ejecutar el script gestionemos: "
    echo "-m, --manual: Muestra el manual de uso del script."
    echo "-d, --dir: Crea directorios resursivamente basados en los argumentos dados. Introduce los nombres, un "+" y los nombres de los siguientes"
    echo "-p, --process <usuario>: Lista todos los procesos en funcionamiento del usuario especificado en un archivo procesos_{usuario}_{fecha_hora}.log y muestra por pantalla el total de procesos en funcionamiento."
    echo "-l, --list [directorio]: Lista todos los ficheros del directorio especificado en un archivo ficheros_{directorio}_{fecha_hora}.log y muestra el total de ficheros por pantalla. Si no se proporciona ningún argumento, se realiza el listado sobre el directorio ${HOME}."
    echo "-k, --kill <PID>: Mata el proceso especificado (PID), solicitando confirmación antes de hacerlo."
    echo "-b, --backup: Crea una copia del directorio ${HOME} y lo comprime en un archivo zip con el nombre backup_{fecha_hora}.zip."
    echo "-log: Realiza la rotación del log.."
    echo "-g, --group: Crea un grupo con el nombre pasado como primer argumento y con el GID pasado como segundo argumento(opcional). Si le añadimos "-r", elimina el grupo con ese nombre. Si no añadimos ningún argumento, muestra por pantalla los grupos del usuario actual."
    echo "-u, --user: Crea un usuario con el nombre pasado como primer argumento.El segundo argumento es el nombre del grupo principal del usuario. El tercer y posteriores argumentos son los grupos secundarios. Si le añadimos la opción -r, elimina el usuario con ese nombre. Si no añadimos ningún argumento, muestra por pantalla el nombre del usuario actual."
}

if [ $palabra == "-m" ] || [ $palabra == "--manual" ]; then
    manual ;
    echo "$fechaHora $0 $@" true >> gestionemos.log;
fi

directorio_creado=""

# ÚLTIMO INCREMENTO
if [ "$palabra" = "-d" ] || [ "$palabra" = "--dir" ];then
    if [[ "$@" == "${easterEgg1[*]}" ]]; then
        echo "Do I look like a gangster? I’m a businessman!"
    elif [[ "$@" == "${easterEgg2[*]}" ]]; then
        echo "Ah shit, here we go again"
    else
        for arg in "$@"; do # $@ representa todos los argumentos pasados al script, y $arg toma cada uno de estos argumentos
            if [ "$arg" != "+" ]; then
                # Aquí estamos comprobando que si el argumento que introduce el usuario es distinto a + entonces entra en el bucle
                mkdir -p "$arg" #Si el argumento actual no es +, se utiliza el comando 
                                #mkdir -p para crear un directorio con el nombre especificado en el argumento.
                                #La opción -p asegura que se creen todos los directorios intermedios necesarios.
                directorio_creado="$arg"
            else
                nuevoDirectorio="$directorio_creado/$arg" #Se construye un nuevo directorio concatenando el valor actual 
                                                        #de directorio_creado con el primer argumento pasado al script, $arg
                mkdir -p "$directorio_creado"
                cd $directorio_creado #Se cambia al directorio creado anteriormente
                directorio_creado="$nuevoDirectorio" # Se actualiza el valor de directorio_creado con el nuevo directorio creado
            fi
        done
    fi
fi

echo "$fechaHora $0 $@" true >> gestionemos.log;

if [ $# -ge 1 ]; then
    usuario=""
    fecha_hora=$(date +'%Y-%m-%d_%H-%M-%S')

    if [ "$palabra" == "-p" ] || [ "$palabra" == "--process" ]; then
        # -U sirve para especificar el nombre del usuario cuyos procesos se desean listar
        ps -U "$usuario" > "${usuario}_${fecha_hora}.log"
        #Esta línea ejecuta el comando ps para mostrar los procesos del usuario especificado por la variable usuario y redirige la salida al archivo ${usuario}_${fecha_hora}.log. ${usuario}_${fecha_hora} 
        #es una forma de concatenar las variables usuario y fecha_hora para formar el nombre del archivo :)
        ps "$usuario" | wc -l #cuenta el número de líneas de salida
        echo "$fechaHora $0 $@" true >> gestionemos.log;
    fi
    

    if [ "$palabra" == "-l" ] || [ "$palabra" == "--list" ]; then
        # Si pones un argumento, toma como directorio el argumento 1, si no, toma HOME como directorio
        if [ -z "$1" ]; then
            directorio="$HOME"
        else
            directorio="$1"
        fi
        
        fechaHora=$(date +"%Y%m%d_%H%M%S")
        # Lista los archivos y directorios en el directorio especificado por la variable $directorio
        ls -l "${directorio}" > "ficheros_${directorio}_${fechaHora}.log"
        echo "Total de ficheros en $directorio: "
        # Cuenta el número total de líneas
        ls -l "$directorio" | wc -l
        echo "$fechaHora $0 $@" true >> gestionemos.log
    fi  

    if [ "$palabra" == "-k" ] || [ "$palabra" == "--kill" ]; then
        echo "Ingrese el PID del proceso que desea matar: "
        read pid
        kill $pid
        echo "$fechaHora $0 $@" true >> gestionemos.log;
    fi

    if [ "$palabra" == "-b" ] || [ "$palabra" == "--backup" ]; then
        fecha_hora=$(date +"%Y%m%d_%H%M%S")
        #Zip crea una estructura completa de archivos
        #Ejecuta el comando zip para comprimir recursivamente (-r) el contenido del directorio especificado
        #por la variable $HOME en un archivo ZIP con un nombre que
        #incluye la fecha y hora en que se realizó la copia de seguridad
        zip -r "backup_{$fechaHora}.zip" "$HOME"
        echo "Copia de seguridad creada en backup_${fechaHora}.zip."
        echo "$fechaHora $0 $@" true >> gestionemos.log;
    fi 
fi

#PRIMER INCREMENTO
fecha_hora_actual=$(date +"%Y-%m-%d_%H:%M:%S")
comando_completo="$0 $*"

#Se concatena $0 $* para obtener el comando completo que se ejecutó,
#donde $0 es el nombre del script y $* son todos los args pasados al script.
if [ "$palabra" == "--log" ]; then
    fechaHora="$(date +'%Y_%m_%d_%H_%M')"
    mv gestionemos.log "gestionemos_$fechaHora.log"
    touch gestionemos.log
    echo "$fechaHora $0 $@" true >> gestionemos.log;
fi

# SEGUNDO INCREMENTO

if [ $palabra == "-g" ] || [ $palabra == "--group" ]; then
    if [ -z "$2" ]; then
        echo "Nombre de Usuario: "
        #Imprime en la salida el nombre del usuario que ha iniciado sesión en la sesión actual del sistema
        whoami
        echo "Grupos del usuario: "
        # Se utiliza para mostrar información sobre grupos de usuarios del sistema
        getent group
    else
        if [ "$2" == "-r" ]; then
            EliminarGrupos "$3"
        else
            shift
            CreacionGrupos "$@"
        fi
        echo "$fechaHora $0 $@" true >> gestionemos.log;
    fi
    echo "$fechaHora $0 $@" true >> gestionemos.log;

elif [  $palabra == "-u" ] || [ $palabra == "--user" ]; then
    if [ -z "$2" ]; then
        echo "Usuario actual: $(whoami)"
    else
        if [ "$2" == "-r" ]; then
            EliminarUsuarios "$3"
        else
            shift
            CreacionUsuarios "$@"
        fi
        echo "$fechaHora $0 $@" true >> gestionemos.log;
    fi
fi
