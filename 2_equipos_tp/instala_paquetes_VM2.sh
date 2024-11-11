#!/bin/bash

# Actualizar el repositorio
sudo dnf -y update

# Instalar los paquetes
sudo dnf -y install tree sshpass ansible ca-certificates curl

# Eliminar los paquetes relacionados con Docker
for pkg in docker-ce docker-ce-cli containerd.io docker-compose podman-docker; do
    sudo dnf remove -y $pkg
done

# Agregar repositorio de Docker en Fedora 33

sudo dnf install dnf-plugins-core -y

sudo tee /etc/yum.repos.d/docker-ce.repo<<EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/33/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF

# Instalar Docker

sudo dnf makecache -y
sudo dnf install docker-ce docker-ce-cli containerd.io -y

# Añadir el grupo Docker al usuario

sudo usermod -a -G docker vagrant

# Iniciar servicio

sudo systemctl enable --now docker