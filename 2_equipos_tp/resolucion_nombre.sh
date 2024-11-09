#!/bin/bash

# Variables

IP_VM1="192.168.56.4"
NOMBRE_VM1="VM1-Grupo-001"

IP_VM2="192.168.56.5"
NOMBRE_VM2="VM2-Grupo-001"

# Verificar y agregar la entrada para VM1
if ! grep -q "$IP_VM1" /etc/hosts; then
        echo "Agregando $IP_VM1 $NOMBRE_VM1 a /etc/hosts."
        echo "$IP_VM1 $NOMBRE_VM1" | sudo tee -a /etc/hosts
fi

# Verificar y agregar la entrada para VM2
if ! grep -q "$IP_VM2" /etc/hosts; then
        echo "Agregando $IP_VM2 $NOMBRE_VM2 a /etc/hosts."
        echo "$IP_VM2 $NOMBRE_VM2" | sudo tee -a /etc/hosts
fi
