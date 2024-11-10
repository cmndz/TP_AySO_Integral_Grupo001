#!/bin/bash

# Lista de usuarios
USUARIOS=("TP_202411_Prog1" "TP_202411_Prog2" "TP_202411_Test1" "TP_202411_Supervisor")

# Configurar sudo sin contraseña para cada usuario

# Recorrer la lista de usuarios
for usuario in "${USUARIOS[@]}"; do
	# Verifica si existe el usuario
	if id "$usuario" &>/dev/null; then
		CONFIG="$usuario ALL=(ALL) NOPASSWD:ALL"
		# Verifica que no exista la entrada en /etc/sudoers.d
		if ! sudo grep -q "^$CONFIG" /etc/sudoers.d/"$usuario" 2>/dev/null; then
			echo "$CONFIG" | sudo tee /etc/sudoers.d/"$usuario" > /dev/null
			sudo chmod 440 /etc/sudoers.d/"$usuario"
			echo "Configurado sudo sin contraseña para $usuario."
		else
			echo "Configuración de sudo ya existente para $usuario."
		fi
	else
		echo "El usuario $usuario no existe."
	fi
done
