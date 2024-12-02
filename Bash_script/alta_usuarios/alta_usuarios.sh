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
#if [ -z "$LISTA" ]; then
#	echo "Lista de usuarios no proporcionada"
#	exit 1
#fi

#Chequeo que el archivo exista
#if [ ! -f "$LISTA" ]; then
#	echo "El archivo $LISTA no existe"
#	exit 1
#fi

#Chequeo que el user haya sido proporcionado
#if [ -z "$USUARIO_PARAMETRO" ]; then
#	echo "Usuario no proporcionado"
#	exit 1
#fi

#Chequeo que el user exista
#if ! grep -q "^$USUARIO_PARAMETRO:" /etc/passwd; then
#	echo "El usuario $USUARIO_PARAMETRO no existe"
#	exit 1
#fi

CLAVE=$(sudo grep $USUARIO_PARAMETRO /etc/shadow | awk -F ':' '{print $2}')

#Chequeo si la clave es valida
if [ -z "$CLAVE" ]; then
	echo "No se pudo obtener la clave de $USUARIO_PARAMETRO"
	exit 1
fi

# Verificar si la clave comienza con '!' (usuario bloqueado)
if [[ "$CLAVE" == !* ]]; then
	echo "El usuario $USUARIO_PARAMETRO está bloqueado"
	exit 2
fi

ANT_IFS=$IFS

IFS=$'\n'
for LINEA in `cat $LISTA |  grep -v ^#`
do
	USUARIO=$(echo $LINEA |awk -F ',' '{print $1}')
	GRUPO=$(echo $LINEA |awk -F ',' '{print $2}')
	HOME_USUARIO=$(echo $LINEA |awk -F ',' '{print $3}')
	
	#Chequeo que grupo no exista
	if ! grep "^$GRUPO:" /etc/group; then
		sudo groupadd $GRUPO
	fi

	#Creo el usuario
	sudo useradd -m -d $HOME_USUARIO -s /bin/bash -p $CLAVE -g $GRUPO $USUARIO
done
IFS=$ANT_IFS

