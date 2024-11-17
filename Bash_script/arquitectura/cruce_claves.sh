#!/bin/bash

# variables
LOCAL_HOSTNAME=$(hostname)
REMOTE_USER=$USER
KEY_PATH="$HOME/.ssh/id_ed25519"
PASS="vagrant"

# Definir el nombre de la otra máquina según el host actual
if [ "$LOCAL_HOSTNAME" == "VM1-Grupo-001" ]; then
	REMOTE_HOST="VM2-Grupo-001"  # Nombre de la segunda máquina si estamos en la primera
elif [ "$LOCAL_HOSTNAME" == "VM2-Grupo-001" ]; then
	REMOTE_HOST="VM1-Grupo-001"  # Nombre de la primera máquina si estamos en la segunda
fi

# Generar la clave SSH ed25519 si no existe
if [ ! -f "$KEY_PATH" ]; then
	ssh-keygen -t ed25519 -f "$KEY_PATH" -q -N ""
fi

# iniciar agente ssh y agregar la clave

eval $(ssh-agent -s)
ssh-add "$KEY_PATH"

# Copiar la clave pública al archivo authorized_keys en la máquina local
cat "$KEY_PATH.pub" >> ~/.ssh/authorized_keys

# Copiar la clave pública a la máquina remota
sshpass -p "$PASS" ssh-copy-id -i "$KEY_PATH.pub" "$REMOTE_USER@$REMOTE_HOST"

