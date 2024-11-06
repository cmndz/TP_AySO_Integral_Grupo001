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
if [ -z "$LISTA" ]; then
	echo "Archivo de parametro no proporcionado"
	exit 1
fi

#Chequeo que el archivo existe
if [ ! -f "$LISTA" ]; then
	echo "El archivo parametro no existe"
	exit 1
fi

ANT_IFS=$IFS
IFS=$'\n'

#---- Dentro del bucle ----#
for URL in $(cat "$LISTA"); do
  # Obtener el código de estado HTTP
  STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  # Fecha y hora actual en formato yyyymmdd_hhmmss
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

  #Creo el path del archivo log y nombre de arhivo
  DIR=""
  NOMBRE_ARCHIVO=""

 # Registrar en el archivo /var/log/status_url.log
  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" |sudo tee -a  "$LOG_FILE"

  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" > "$DIR/$NOMBRE_ARCHIVO.log"

done
#-------------------------#

IFS=$ANT_IFS
