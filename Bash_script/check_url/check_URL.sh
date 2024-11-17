#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista Dominios y URL
#
#  Tareas:
#  - Se debera generar la estructura de directorio pedida con 1 solo comando con las tecnicas enseñadas en clases
#  - Generar los archivos de logs requeridos.
#
###############################
LISTA=$1

LOG_FILE="/var/log/status_url.log"

#Chequeo que el parametro haya sido proporcionado
#if [ -z "$LISTA" ]; then
#	echo "Archivo de parametro no proporcionado"
#	exit 1
#fi

#Chequeo que el archivo existe
#if [ ! -f "$LISTA" ]; then
#	echo "El archivo parametro no existe"
#	exit 1
#fi

ANT_IFS=$IFS
IFS=$'\n'

#Genero Estructura de directorios
mkdir -p /tmp/head-check/{Error/{cliente,servidor},ok}

#---- Dentro idel bucle ----#
for LINEA in `cat $LISTA |  grep -v ^#`; do

	#Extraigo URL y Dominio
	URL=$(echo $LINEA | awk '{print $2}')
  	DOM=$(echo $LINEA | awk '{print $1}')

  	# Obtener el código de estado HTTP
  	STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  	# Fecha y hora actual en formato yyyymmdd_hhmmss
  	TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

  	#Creo el path del archivo log y nombre de arhivo
  	FILEPATH="/tmp/head-check"
	DIR=""

 	if [ "$STATUS_CODE" -gt 499 ]; then
	  	DIR="$FILEPATH/Error/servidor"
  	elif [ "$STATUS_CODE" -gt 399 ]; then
		DIR="$FILEPATH/Error/cliente"
  	else
	  	DIR="$FILEPATH/ok"
  	fi

 	# Registrar en el archivo /var/log/status_url.log
  	echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" |sudo tee -a  "$LOG_FILE"

  	echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" > "$DIR/$DOM.log"

done
#-------------------------#

IFS=$ANT_IFS

#Muestro el resultado
echo "######## Logs resultantes ########"
tree /tmp/head-check
cat $LOG_FILE
