#!/bin/bash

RUTA="/home/vagrant/repogit/TP_AySO_Integral_Grupo001"
DESTINO="/usr/local/bin"

# copiar scripts desde el repositorio a /usr/local/bin para poder ejecutarlos desde ahí

sudo cp $RUTA/ejecutar_bash_scripts.sh $DESTINO

sudo cp $RUTA/Bash_script/alta_usuarios/alta_usuarios.sh $DESTINO

sudo cp $RUTA/Bash_script/check_url/check_URL.sh $DESTINO

sudo cp $RUTA/Bash_script/arquitectura/cruce_claves.sh $DESTINO

sudo cp $RUTA/Bash_script/arquitectura/particionado_lvm.sh $DESTINO

sudo cp $RUTA/Bash_script/arquitectura/quitar_pass_sudo.sh $DESTINO

sudo cp $RUTA/copiar_scripts.sh $DESTINO
