#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista de Usuarios a crear
#  - Usuario del cual se obtendra la clave
#
#  Tareas:
#  - Crear los usuarios segun la lista recibida en los grupos descriptos
#  - Los usuarios deberan de tener la misma clave que la del usuario pasado por parametro
#
###############################

LISTA=$1
USUARIO_PARAMETRO=$2
#Chequeo que el archivo haya sido proporcionado
if [ -z "$LISTA" ]; then
	echo "Archivo parametro no proporcionado"
	exit 1
fi

#Chequeo que el archivo exista
if [ ! -f "$LISTA" ]; then
	echo "El archivo $LISTA no existe"
	exit 1
fi

#Chequeo que el user haya sido proporcionado
if [ -z "$USUARIO_PARAMETRO" ]; then
	echo "Usuario parametro no proporcionado"
	exit 1
fi

#Chequeo que el user exista
if [ ! id $USUARIO_PARAMETRO %>/dev/null ]; then
	echo "El usuario parametro no existe"
	exit 1
fi

CLAVE=$(sudo cat /etc/shadow | grep $2 | awk -F ':' '{print $2}')

#Chequeo si la clave es valida
if [ -z "$CLAVE" ]; then
	echo "No se pudo obtener la clave de $USUARIO_PARAMETRO"
	exit 1
fi


ANT_IFS=$IFS

IFS=$'\n'
for LINEA in `cat $LISTA |  grep -v ^#`
do
	USUARIO=$(echo  $LINEA |awk -F ':' '{print $1}')
	GRUPO=$(echo  $LINEA |awk -F ':' '{print $2}')

	#Chequeo que grupo no exista
	if [!getent group "$GRUPO" &>/dev/null]; then
		sudo groupadd "$GRUPO"
	fi

	#Creo el usuario
	sudo useradd -m -s /bin/bash -p $CLAVE -g $GRUPO $USUARIO
done
IFS=$ANT_IFS

