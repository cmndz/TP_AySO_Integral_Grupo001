#!/bin/bash

RUTA="$HOME/repogit/TP_AySO_Integral_Grupo001/Bash_script/"

# Ejecutar script alta usuarios
echo "Ejecutando alta_usuarios.sh"

if bash "${RUTA}alta_usuarios/alta_usuarios.sh" "${RUTA}alta_usuarios/Lista_Usuarios.txt" vagrant; then
	echo "alta_usuarios.sh se ejecutó correctamente."
else
	echo "Error al ejecutar alta_usuarios.sh"
	exit 1
fi


# Ejecutar script cruce claves
echo "Ejecutando cruce_claves.sh"

if bash "${RUTA}arquitectura/cruce_claves.sh"; then
	echo "cruce_claves.sh se ejecutó correctamente."
else
	echo "Error al ejecutar cruce_claves.sh"
	exit 1
fi


# Ejecutar script quitar contraseña con sudo
echo "Ejecutando quitar_pass_sudo.sh"

if bash "${RUTA}arquitectura/quitar_pass_sudo.sh"; then
	echo "quitar_pass_sudo.sh se ejecutó correctamente."
else
	echo "Error al ejecutar quitar_pass_sudo.sh"
	exit 1
fi


# Ejecutar script particionado y lvm
echo "Ejecutando particionado_lvm.sh"

if bash "${RUTA}arquitectura/particionado_lvm.sh"; then
	echo "particionado_lvm.sh se ejecutó correctamente."
else
	echo "Error al ejecutar particionado_lvm.sh"
	exit 1
fi


# Ejecutar script check url
echo "Ejecutando check_URL.sh"

if bash "${RUTA}check_url/check_URL.sh" "${RUTA}check_url/Lista_URL.txt"; then
	echo "check_URL.sh se ejecutó correctamente."
else
	echo "Error al ejecutar check_URL.sh"
	exit 1
fi

echo "Todos los scripts se ejecutaron."
