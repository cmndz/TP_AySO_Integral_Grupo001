#!/bin/bash
clear
echo "###########################################"
echo "Verificaciones Previas"
echo "###########################################"
echo "Se Verifica SI estan Montados"
echo
if  sudo df -h | grep -E "/dev/mapper/vg_datos-lv_docker|/dev/mapper/vg_datos-lv_workareas"; then
	sudo umount /dev/mapper/vg_datos-lv_docker
	sudo umount /dev/mapper/vg_datos-lv_workareas
fi
echo
echo "Ya NO estan Montados"
echo "###########################################"
echo "Se Verifica SI existen los LV"
echo
if sudo ls -l /dev/mapper | grep -E "/dev/mapper/vg_datos-lv_docker|/dev/mapper/vg_datos-lv_workareas|vg_temp-lv_swap"; then
	sudo wipefs -a /dev/mapper/vg_datos-lv_docker
	sudo lvremove -f /dev/mapper/vg_datos-lv_docker
	sudo wipefs -a /dev/mapper/vg_datos-lv_workareas
	sudo lvremove -f /dev/mapper/vg_datos-lv_workareas
	sudo swapoff /dev/mapper/vg_temp-lv_swap
	sudo wipefs -a /dev/mapper/vg_temp-lv_swap
	sudo lvremove -f /dev/mapper/vg_temp-lv_swap
fi
echo
echo "Ya NO existen los LV"
echo "###########################################"
echo "Se Verifica SI existen los VG"
echo
if sudo vgs | grep -E "vg_datos|vg_temp"; then
	sudo vgremove -f vg_datos vg_temp
fi
echo
echo "Ya NO existen los VG"
echo "###########################################"
DISCO01=$(sudo fdisk -l | grep "Disk /dev/sd" | grep "5 GiB" | awk '{print $2}' | awk -F ':' '{print $1}')
DISCO02=$(sudo fdisk -l | grep "Disk /dev/sd" | grep "3 GiB" | awk '{print $2}' | awk -F ':' '{print $1}')
DISCO03=$(sudo fdisk -l | grep "Disk /dev/sd" | grep "2 GiB" | awk '{print $2}' | awk -F ':' '{print $1}')
echo "Se Verifica SI existen los PV"
echo
if sudo pvs | grep -E "${DISCO01}1|${DISCO02}1|${DISCO03}2"; then
	sudo pvremove ${DISCO01}1
	sudo pvremove ${DISCO02}1
	sudo pvremove ${DISCO03}2
fi
echo
echo "Ya NO existen los PV"
echo "###########################################"
echo "Se limpian las Particiones"
echo
sudo wipefs -a $DISCO01
sudo wipefs -a $DISCO02
if sudo fdisk -l | grep ${DISCO03}1 | grep swap; then
	sudo swapoff ${DISCO03}1
	sudo wipefs -a ${DISCO03}1
fi
sudo wipefs -a $DISCO03
echo

echo "###########################################"
echo "Inicio del Script"
echo "###########################################"
echo "DISCO DE 5GB: $DISCO01"
echo "Particion al 100% y cambio al Tipo de Particion 8E (LVM)"
sudo fdisk $DISCO01 << EOF
n
p



t
8E
w
EOF
echo "###########################################"
echo "DISCO DE 3GB: $DISCO02"
echo "Particion al 100% y cambio al Tipo de Particion 8E (LVM)"
sudo fdisk $DISCO02 << EOF
n
p



t
8E
w
EOF
echo "###########################################"
echo "DISCO DE 2GB: $DISCO03"
echo "Particion 1, cambio al Tipo de Particion 82 (SWAP)"
echo "Particion 2, cambio al Tipo de Particion 8E (LVM)"
sudo fdisk $DISCO03 << EOF
n
p


+1G
n
p



t
1
82
t
2
8E
w
EOF
echo "###########################################"
echo "Se Crean los PVs"
echo
sudo pvcreate ${DISCO01}1 ${DISCO02}1 ${DISCO03}2
echo "###########################################"
echo "Se Crean los VGs (vg_datos y vg_temp)"
echo
sudo vgcreate vg_datos ${DISCO01}1
sudo vgcreate vg_temp ${DISCO02}1 ${DISCO03}2
echo "###########################################"
echo "Se Crean los LVs (lv_docker, lv_workareas y lv_swap)"
echo
sudo lvcreate -L 10M vg_datos -n lv_docker
sudo lvcreate -L 2.5GB vg_datos -n lv_workareas
sudo lvcreate -L 2.5GB vg_temp -n lv_swap
echo "###########################################"
echo "Se Crean los File System para lv_docker y lv_workareas"
echo
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
echo "###########################################"
echo "Se Crean los Directorios /work y /var/lib/docker" 
echo "(en caso de existir, -p no genera error)"
echo
sudo mkdir -p /work
sudo mkdir -p /var/lib/docker
echo "###########################################"
echo "Se Monta lv_docker en /var/lib/docker"
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
echo
echo "Se Monta lv_workareas en /work"
sudo mount /dev/mapper/vg_datos-lv_workareas /work
echo
echo "Se Monta Disco ${DISCO03}1 como SWAP"
sudo mkswap ${DISCO03}1
sudo swapon ${DISCO03}1
echo
echo "Se Monta lv_swap como SWAP"
sudo mkswap /dev/mapper/vg_temp-lv_swap
sudo swapon /dev/mapper/vg_temp-lv_swap
echo

echo "###########################################"
echo "Se extiende y redimensiona lv_docker"
sudo lvextend -L 2G /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker

echo "###########################################"
echo "Fin del Script"
echo "###########################################"
echo

