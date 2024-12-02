Ya se encuentra todo pusheado a la rama main 👌🏻

Lo primero que van a hacer imagino es **clonar** el repo:

> <code>git clone https://github.com/cmndz/TP_AySO_Integral_Grupo001.git</code> </br>
> <code>cd TP_AySO_Integral_Grupo001</code> </br> </br>
> ![image](https://github.com/user-attachments/assets/78df58b9-7c07-4843-aa39-faec6609f387)</br>
> *(Los archivos del Repo)*

Ya no hace falta moverse a dev o a ninguna otra rama, lo ultimo de lo ultimo esta en **main**. 

Asimismo, **main** quedo bloqueada, solo es de lectura *(o sea digamos no permite push)*.

> ![image](https://github.com/user-attachments/assets/2b64f0c2-1409-47dc-a856-4fa31cea374f)

# Las VMs

El VagrantFile con los scripts que levantan las VMs esta en **2_equipos_tp**

> <code>cd 2_equipos_tp</code></br>
> <code>vagrant up</code></br></br>
> *# 192.168.56.4 - testing - VM1-Grupo-001 - Ubuntu*</br>
> *# 192.168.56.5 - produccion - VM2-Grupo-001 - Fedora*

Una vez levantadas las VMs, acceder *(por ejemplo a la 192.168.56.4, es decir testing)*:

> <code>ssh vagrant@192.168.56.4</code></br>

Indicar la contraseña *(vagrant)*

> ![image](https://github.com/user-attachments/assets/f4131ac7-ecbe-4ac5-81da-9498bba21ad6)

Y estamos adentro:
> ![image](https://github.com/user-attachments/assets/71bf4270-b74b-499d-b6d2-d79a189c56c2)
> 
##  Nota: Si destruimos anteriormente la VM, nos va a aparecer una mensaje similar al siguiente:

> ![image](https://github.com/user-attachments/assets/644d2a0f-17cc-4611-979d-f325ee8c826b)

Va a ser necesario reescribir la clave ssh:

> <code>ssh-keygen -R 192.168.56.4</code></br>

Y volver a intentar ingresar:

> <code>ssh vagrant@192.168.56.4</code></br>

Seguramente pida confirmmar antes de continuar, solo poner ***yes***
> ![image](https://github.com/user-attachments/assets/6dc94ff3-767f-4201-8959-06355ad53be0)

Indicar la contraseña *(vagrant)*

> ![image](https://github.com/user-attachments/assets/f4131ac7-ecbe-4ac5-81da-9498bba21ad6)

Y estamos adentro:
> ![image](https://github.com/user-attachments/assets/71bf4270-b74b-499d-b6d2-d79a189c56c2)

##  Nota: Segun las ultima clases, en el parcial solo vamos a utilizar solo la VM con Ubuntu

Para levantar una sola VM *(por ejemplo la de testing)*:

> <code>vagrant up testing</code></br>

##

Una vez dentro de la **VM**, todo lo relacionado al **TP** se encuentra en:

> <code>cd repogit/TP_AySO_Integral_Grupo001</code></br>


# Bash scripts

Los scripts se encuentran en **Bash_script**: 

> <code>cd Bash_script</code></br></br>
> ![image](https://github.com/user-attachments/assets/27b8c386-5c66-4f87-9c5a-0bb3c02813b7)</br>
> *(Los archivos de Bash_scrip)*


## Alta Usuarios
Requiere dos parametros:</br>
1. La lista de Usuarios, en este caso **Lista_Usuarios.txt**</br>
2. El Usuario del que se va a tomar la **Clave** para el resto de Usuarios, en este caso **vagrant**</br>

Entonces:

> <code>bash alta_usuarios/alta_usuarios.sh alta_usuarios/Lista_Usuarios.txt vagrant</code></br>

Para verificar: </br>

> <code>grep "TP_202411" /etc/passwd</code></br></br>
> ![image](https://github.com/user-attachments/assets/e61f0da3-4cf8-4684-b951-de488b3977c7)

## Check URL
Requiere un parametro:</br>
1. La lista de URLs, en este caso **Lista_URL.txt**</br>

Entonces:

> <code>bash check_url/check_URL.sh check_url/Lista_URL.txt</code></br>

Para verificar: </br>

> <code>tree /tmp/head-check/</code></br></br>
> ![image](https://github.com/user-attachments/assets/6a202add-9bc2-4649-9117-c0166570dce2)

## Cruce Claves

**ANTES de ejecutar cruce_claves.sh**, primero deben ingresar una vez a la otra VM *(192.168.56.5 - produccion - VM2-Grupo-001)* desde la VM en la que estan *(192.168.56.4 - testing - VM1-Grupo-001)*

> <code>ssh vagrant@VM2-Grupo-001</code></br></br>

Seguramente pida confirmmar antes de continuar, solo poner ***yes***
> ![image](https://github.com/user-attachments/assets/6dc94ff3-767f-4201-8959-06355ad53be0)

Indicar la contraseña *(vagrant)*
> ![image](https://github.com/user-attachments/assets/ac55c857-9650-42fa-a2e0-4e080ff3587d)

Y estamos adentro de **VM2**:
> ![image](https://github.com/user-attachments/assets/f973ec42-40f4-4ce7-bfa3-1277bbea6124)

Para volver a la **VM1**, hacerlo con "exit" o ctrl+d

##

Ahora si:

> <code>bash arquitectura/cruce_claves.sh</code></br></br>
> ![image](https://github.com/user-attachments/assets/55a7db70-5afe-4a4e-9cc0-041352886c79)</br>
> *(Aparecera un mensaje similar al siguiente)*

Ahora podemos acceder a **VM2 desde VM1, sin que nos solicite la contraseña**

Para verificar: </br>
> <code>ssh vagrant@VM2-Grupo-001</code></br></br>
![image](https://github.com/user-attachments/assets/77172094-e1ac-424b-82f1-d5ad61eaf933)

Tambien deberiamos poder acceder a la **VM1 desde la propia VM1 sin contraseña**
> <code>ssh vagrant@VM1-Grupo-001</code></br>

**QUE SE PUEDE CONECTAR A AMBAS VM SIN CONTRASEÑA ES IMPORTANTISIMO PARA PODER UTILIZAR ANSIBLE**

## Particionado LVM
Es este script ya se encuentra agregado el lvextend para atrapar el error de falta de espacio que deberia arrojar docker

Solo ejecutarlo:
> <code>bash arquitectura/particionado_lvm.sh</code></br>

Para verificar: </br>

> <code>sudo pvs</code></br></br>
> ![image](https://github.com/user-attachments/assets/b6d9c00c-ff6a-4046-bbd6-09062e7d79d8)

> <code>sudo vgs</code></br></br>
> ![image](https://github.com/user-attachments/assets/c1347339-efd6-4746-b410-140e1f610a38)

> <code>sudo lvs</code></br></br>
> ![image](https://github.com/user-attachments/assets/9c659078-b111-4da6-9c1e-cf1f22ac47b4)

## Quitar Pass 
Este script esta armado para afectar a los **Usuarios** creados mediante **script**, como a los creados por **ansible**.
Es por ello que al ejecutarlo en esta instancia (ya que todavia no tenemos aplicado lo de ansible), puede presentarse un **mensaje de que no existen algunos usuarios**.

> ![image](https://github.com/user-attachments/assets/7d235c22-9978-4012-820b-24125c17504c)

Para ejecutarlo:
> <code>bash arquitectura/quitar_pass_sudo.sh</code></br>

#

Para subir un nivel en la estructura de directorios:
> <code>cd ..</code></br></br>

# Ansible

La parte de Ansible no requiere mucha explicacion

Los archivos se encuentran en **ansible**: 

> <code>cd ansible</code></br></br>
> ![image](https://github.com/user-attachments/assets/8e8aa7aa-0691-4bb6-bbc1-d740a38ce711)</br>
> *(Los archivos de ansible)*

Si el cruce de claves entre las VMs se realizo correctamente, solo queda ejecutar:
> <code>ansible-playbook -i inventory/hosts playbook.yml</code></br></br>
> #Se conecta a ambas VMs</br>
> ![image](https://github.com/user-attachments/assets/03b7ab37-6f70-4e92-9bb5-4d014b146e29)</br></br>
> #TP_INI</br>
> ![image](https://github.com/user-attachments/assets/0e2788d7-8d72-40ae-9c3a-0fbdecb8e345)</br></br>
> #Alta_Usuarios_Grupo-001</br>
> ![image](https://github.com/user-attachments/assets/3206d657-e422-42b0-89e2-3ca9e5879f1f)</br>
> ![image](https://github.com/user-attachments/assets/e65b289b-566c-4d69-8767-656e5108968f)</br></br>
> #Sudoers_Grupo-001</br>
> ![image](https://github.com/user-attachments/assets/680e9ba6-f10b-47ff-89f4-598de05d24d5)</br></br>
> #Instala-tools_Grupo-001</br>
> ![image](https://github.com/user-attachments/assets/8cb6844a-c03f-48be-b47d-2b269b56fc70)</br></br>
> #Bye</br>
> ![image](https://github.com/user-attachments/assets/5a14bf36-4f56-43a1-964e-4703a32f5c68)</br>

#

Para subir un nivel en la estructura de directorios:
> <code>cd ..</code></br></br>

# Docker

Los archivos se encuentran en **docker**: 

> <code>cd docker</code></br></br>
> ![image](https://github.com/user-attachments/assets/79cd55ca-83eb-4f1e-a0c8-50b11929dc7c)</br>
> *(Los archivos de docker)*

## Generar un imagen

Dentro de la carpeta **/docker**, que es donde tambien se encuentra el archivo **dockerfile**, ejecutar:
> <code>docker build -t tp-div_313_grupo_grupo001 .</code></br>

##  Nota: En caso de que arroje un error similar al siguiente:

> ![image](https://github.com/user-attachments/assets/5b7c0e8d-9044-42cb-9d80-03e225fad682)

Reiniciar el servicio de docker con:
> <code>sudo systemctl restart docker</code></br>

Y volver a probar el **docker build**

#

Para verificar que se haya generado la imagen: </br>

> <code>docker images</code></br></br>
> ![image](https://github.com/user-attachments/assets/12dcf501-e0d6-43cc-b7a9-de807e1abb4e)


Para correr la imagen:
> <code>docker run -d -p 8080:80 tp-div_313_grupo_grupo001</code></br>


Para verificar que la imagen este corriendo:
> <code>docker ps</code></br></br>
>![image](https://github.com/user-attachments/assets/f87d6fc7-2d90-4b3e-910d-e599ba9fc52e)


Si la imagen se esta corriendo, podemos verificarlo con nuestro navegador: http://192.168.56.4:8080/
> ![image](https://github.com/user-attachments/assets/2504523c-fc90-4764-9797-98d0088ca064)


Para pausar la imagen que esta corriendo:
> <code>docker stop <CONTAINER ID></code></br></br>

## Pushear la imagen a Docker Hub

Suponiendo que ya tenemos un cuenta en **Docker Hub**, hay que **loguearse** en la VM con:

> <code>docker login</code></br></br>
> #Docker les indicara como loguearse, ya sea por Usuario y Clave o por Codigo... as you wish
![image](https://github.com/user-attachments/assets/9c854b93-0851-4e15-a77b-68e1106f5159)

Ademas de hacer login, para subir una imagen a **Docker Hub**, la misma debe respetar cierto formato de nomeclatura:

> <code>< Nombre de usuario de Docker Hub que va a hacer push > \ < Nombre de la Imagen >:< Version, si no se indica, por defecto pone lastest ></code></br>

Entonces, para generar una imagen a partir de la que ya tenemos, con un nombre que respete el formato:

> <code>docker tag tp-div_313_grupo_grupo001 cmndz/tp-div_313_grupo_grupo001:latest</code></br>
> #cmndz es mi usuario en Docker Hub

Para verificar que se haya generado la nueva imagen:
> <code>docker images</code></br></br>
> ![image](https://github.com/user-attachments/assets/8fdc32d8-1dda-488c-a73d-c6efb672cd40)

Finalmente, pushear la imagen:
> <code>docker push cmndz/tp-div_313_grupo_grupo001:latest</code></br></br>
> ![image](https://github.com/user-attachments/assets/84a6e0d8-a670-47cd-9119-15589391496f)</br>
> #Imagen en mi cuenta de **Docker Hub**

## Correr la Imagen desde Docker Compose

Para utilizar la imagen que pushearon, deben modificar el archivo **docker-compose.yml**, ya que el mismo esta apuntando a la imagen que esta en mi cuenta *(cmndz)*:

> ![image](https://github.com/user-attachments/assets/93e3e361-b31e-4bd0-a110-03fd5e499a03)

Una vez modificado el archivo con el usuario de cada uno, ejecutar:

> <code>docker compose up -d</code></br></br>

En este caso, podemos verificar en nuestro navegador con: http://192.168.56.4:8081/
> ![image](https://github.com/user-attachments/assets/aae7f1e8-c4d6-4d97-bcfe-7e77607c4bc7)


Finalmente, una ultima prueba es la de ingresar al archivo **info.txt** y modificarlo:
> ![image](https://github.com/user-attachments/assets/700f9608-1355-437c-9def-208babe566ca) </br>
> ![image](https://github.com/user-attachments/assets/d739f421-dfbf-488b-8301-ae977872118e)

Al recargar la pagina, deberia verse modificada:
> ![image](https://github.com/user-attachments/assets/1358a86c-394f-455a-b07c-ec76e65045b9)


*Puede ser necesario borrar el cache para que actualice.*
