# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "testing" do |vm1Grupo001|
    vm1Grupo001.vm.box = "ubuntu/jammy64"
    vm1Grupo001.vm.hostname = "vm1Grupo001"
    vm1Grupo001.vm.network "private_network", :name => '', ip: "192.168.56.4"

    # Comparto la carpeta del host donde estoy parado contra la vm
    vm1Grupo001.vm.synced_folder 'compartido_Host1/', '/home/vagrant/compartido', 
    owner: 'vagrant', group: 'vagrant' 

    # Agrega la key Privada de ssh en .vagrant/machines/default/virtualbox/private_key
    vm1Grupo001.ssh.insert_key = true
    
    # Agrego discos
    vm1Grupo001.vm.disk :disk, size: "5GB", name: "#{vm1Grupo001.vm.hostname}_extra_storage"
    vm1Grupo001.vm.disk :disk, size: "3GB", name: "#{vm1Grupo001.vm.hostname}_extra_storage2"
    vm1Grupo001.vm.disk :disk, size: "2GB", name: "#{vm1Grupo001.vm.hostname}_extra_storage3"
    vm1Grupo001.vm.disk :disk, size: "1GB", name: "#{vm1Grupo001.vm.hostname}_extra_storage4"

    vm1Grupo001.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "vm1Grupo001"
      vb.cpus = 1
      vb.linked_clone = true
      # Seteo controladora Grafica
      vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']      
    end    

    # Ejecuto scripts
    vm1Grupo001.vm.provision "shell", path: "script_Enable_ssh_password.sh"
    vm1Grupo001.vm.provision "shell", path: "instala_paquetes.sh"
    vm1Grupo001.vm.provision "shell", privileged: false, inline: <<-SHELL
      
      # Los comandos aca se ejecutan como vagrant
  
      mkdir -p /home/vagrant/repogit
      cd /home/vagrant/repogit
      git clone https://github.com/upszot/UTN-FRA_SO_onBording.git 
      git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
      git clone https://github.com/upszot/UTN-FRA_SO_Docker.git
      git clone https://github.com/cmndz/TP_AySO_Integral_Grupo001.git

    SHELL

    # Añadir entradas al archivo /etc/hosts
    vm1Grupo001.vm.provision "shell", inline: <<-SHELL
      echo "192.168.56.4 vm1Grupo001" | sudo tee -a /etc/hosts
    SHELL
    
  end
    
    
  config.vm.define "produccion" do |vm2Grupo001|
    vm2Grupo001.vm.box = "fedora/38-cloud-base" 
    vm2Grupo001.vm.hostname = "vm2Grupo001"
    vm2Grupo001.vm.network "private_network", :name => '', ip: "192.168.56.5"

    # Comparto la carpeta del host donde estoy parado contra la vm
    vm2Grupo001.vm.synced_folder 'compartido_Host2/', '/home/vagrant/compartido'
  
    # Agrega la key Privada de ssh en .vagrant/machines/default/virtualbox/private_key
    vm2Grupo001.ssh.insert_key = true

    # Agrego discos
    vm2Grupo001.vm.disk :disk, size: "5GB", name: "#{vm2Grupo001.vm.hostname}_extra_storage"
    vm2Grupo001.vm.disk :disk, size: "3GB", name: "#{vm2Grupo001.vm.hostname}_extra_storage2"
    vm2Grupo001.vm.disk :disk, size: "2GB", name: "#{vm2Grupo001.vm.hostname}_extra_storage3"
    vm2Grupo001.vm.disk :disk, size: "1GB", name: "#{vm2Grupo001.vm.hostname}_extra_storage4"
    
    vm2Grupo001.vm.provider "virtualbox" do |vb2|
      vb2.memory = "1024"
      vb2.name = "vm2Grupo001"
      vb2.cpus = 1
      vb2.linked_clone = true
      # Seteo controladora Grafica
      vb2.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
    end

    # Ejecuto scripts
    vm2Grupo001.vm.provision "shell", path: "script_Enable_ssh_password.sh"
    vm2Grupo001.vm.provision "shell", privileged: false, inline: <<-SHELL
      
      # Los comandos aca se ejecutan como vagrant
  
      mkdir -p /home/vagrant/repogit
      cd /home/vagrant/repogit
      git clone https://github.com/upszot/UTN-FRA_SO_onBording.git 
      git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
      git clone https://github.com/upszot/UTN-FRA_SO_Docker.git
      git clone https://github.com/cmndz/TP_AySO_Integral_Grupo001.git

    SHELL
    
    # Provisión para instalar
    vm2Grupo001.vm.provision "shell", inline: <<-SHELL
      dnf install -y /home/vagrant/compartido/tree-1.8.0-10.el9.x86_64.rpm

      subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
      dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
    SHELL

    # Añadir entradas al archivo /etc/hosts
    vm2Grupo001.vm.provision "shell", inline: <<-SHELL
      echo "192.168.56.5 vm2Grupo001" | sudo tee -a /etc/hosts
    SHELL

  end
  
end