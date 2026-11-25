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





#############################################################
## Comprobamos si el segundo argumento es una letra b, B,  ##
## k, K, m o M, y asignamos los valores de las variables   ##
## UNIDAD y BYTESEQUIV cuando proceda                      ##
#############################################################







#############################################################
## Recorremos los elementos del directorio y borramos los  ##
## ficheros regulares cuyo tamaño supere el umbral         ##
#############################################################








#############################################################
## Visualizamos los datos validados en variables:          ##
#############################################################
echo -e "FOLDER=$FOLDER\nUMBRAL=$UMBRAL"
echo -e "UNIDAD=$UNIDAD\nBYTESEQUIV=$BYTESEQUIV"

exit 0

