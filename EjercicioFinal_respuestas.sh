#!/bin/bash

#############################################################
## Comprobamos el número de parámetros y asignamos el      ##
## valor de la variable FOLDER cuando proceda              ##
#############################################################
if [ $# -ne 2 ] && [ $# -ne 3 ]
then
    echo "Modo de uso: $0 umbral unidad [ directorio ]"
    exit 1
fi

FOLDER=${3:-.}

#############################################################
## Comprobamos si el directorio existe y lo es             ##
#############################################################
if [ ! -d "$FOLDER" ]
then
    echo "Directorio $FOLDER no existe o bien no es un directorio"
    exit 2
fi

#############################################################
## Comprobamos si el primer argumento es un número entero  ##
## y asignamos el valor de la variable UMBRAL si procede   ##
#############################################################
ase "$1" in
    "" | *[!0-9]*)
        # Vacío o contiene algún carácter que no es un dígito
        echo "Se requiere un número entero, pero se ha proporcionado: $1"
        exit 3
        ;;
    *)
        UMBRAL=$1
        ;;
esac

#############################################################
## Comprobamos si el segundo argumento es una letra b, B,  ##
## k, K, m o M, y asignamos los valores de las variables   ##
## UNIDAD y BYTESEQUIV cuando proceda                      ##
#############################################################

case "$2" in
    b | B)
        UNIDAD=bytes
        BYTESEQUIV=1
        ;;
    k | K)
        UNIDAD=kibibytes
        BYTESEQUIV=1024
        ;;
    m | M)
        UNIDAD=mebibytes
        BYTESEQUIV=$((1024 * 1024))
        ;;
    *)
        echo "Unidad de medida no válida: $2. Se requiere b, B, k, K, m o M"
        exit 4
        ;;
esac

#############################################################
## Recorremos los elementos del directorio y borramos los  ##
## ficheros regulares cuyo tamaño supere el umbral         ##
#############################################################

LIMITE=$((UMBRAL * BYTESEQUIV))

for FICHERO in "$FOLDER"/*
do
    if [ -f "$FICHERO" ]
    then
        BYTESFICHERO=$(wc -c < "$FICHERO")
        BYTESFICHERO=$((BYTESFICHERO))
        if [ $BYTESFICHERO -gt $LIMITE ]
        then
            if [ $BYTESEQUIV -eq 1 ]
            then
                OCUPA=$BYTESFICHERO
            else
                OCUPA=$(awk -v t=$BYTESFICHERO -v e=$BYTESEQUIV 'BEGIN { printf "%.2f", t / e }')
            fi
            echo "+ Se borra fichero $(basename "$FICHERO"), que ocupa $OCUPA $UNIDAD en disco"
            rm "$FICHERO"
        fi
    fi
done

#############################################################
## Visualizamos los datos validados en variables:          ##
#############################################################
echo -e "FOLDER=$FOLDER\nUMBRAL=$UMBRAL"
echo -e "UNIDAD=$UNIDAD\nBYTESEQUIV=$BYTESEQUIV"

exit 0

