#Configuración DMZ Doble

A continuación vamos a detallar paso a paso como realizar una configuración de un DMZ doble simulado en un entorno empresarial utilizando máquinas virtuales.

**¿Que es un DMZ Doble?**

Un DMZ o zona desmilitarizada, es una zona segura que se ubica entre la red interna de una organización y una red externa, generalmente en Internet.

El objetivo de una DMZ es que las conexiones desde la red interna y la externa a la DMZ estén permitidas, mientras que en general las conexiones desde la DMZ solo se permitan a la red externa.

Para poder entender mejor la estructura que queremos desarrollar podemos observar la siguiente imagen.

![diseño](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/dise%C3%B1o.png)

En éste diseño los elementos que implementaremos serán 6 (2 Pc's, 2 routers y 2 servidores) obviaremos los switches pues en nuestro caso no serán necesarios.

En concreto crearemos 6 máquinas virtuales, todas ellas con ubuntu server (en los Pc's no es necesario que el sistema operativo sea de tipo servidor). Desde los siguentes enlaces podremos descargar ubuntu, tanto [server](http://www.ubuntu.com/download/server) como [desktop](http://www.ubuntu.com/download/desktop).

El software de virtualización que usaremos es Virtualbox el cual podemos descargar desde [aquí](https://www.virtualbox.org/wiki/Downloads), aunque se podría usar cualquier otro como vmware etc.



###Detalle de las máquinas y el software que se instalará en cada una de ellas

- Internet-Cliente: Simulará a un cliente de Internet.
   - Sistema Operativo Ubuntu.
- Firewall-Sur: Hará las funciones de router y firewall.
   - Sistema Operativo Ubuntu Server
   - SSH
- ServidorWeb: Servidor Web.
   - Sistema Operativo Ubuntu Server
   - SSH
   - Apache
   - PHP
   - Mysql
   - FTP
- ServidorApp: Servidor de aplicaciones.
   - Sistema Operativo Ubuntu Server
   - SSH
   - Mysql
- Firewall-Norte: Hará las funciones de router y firewall.
   - Sistema Operativo Ubuntu Server
   - SSH
- Empresa-Cliente: Simulará un cliente de la red interna corporativa.
   - Sistema Operativo Ubuntu.


###Creación de las Máquinas Virtuales

####Instalación Internet-Cliente

Una vez tengamos virtualbox y nuestro sistema operativo descargado procederemos a crear la máquina virtual. Como dijimos anteriormente en lás máquinas cliente podemos instalar cualquier tipo de sistema operativo (desktop o server) nosotros realizaremos el ejemplo instalando Ubuntu Server 12.04.5.

**Pasos a seguir**

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservado dinamicamente.

2) En las configuraciones de red de la máquina dejaremos la red NAT configurada por defecto (para poder descargar posibles paquetes necesarios de internet) y añadiremos otra interfaz de tipo RED INTERNA y asignandole como nombre de red "Red 0".

![configRed_InternetCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed_internetCliente.png)

3) Seguiremos el proceso de instalación habitual de ubuntu, sin instalar ningún tipo de servicio a parte.


####Instalación Firewall-Norte

**Pasos a seguir**

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservado dinamicamente.

2) En las configuraciones de red de la máquina dejaremos la red NAT configurada por defecto (para poder descargar posibles paquetes necesarios de internet) y añadiremos dos interfaces de red de tipo RED INTERNA (una que se conectará a la red de la máquina cliente y otra que se conectará a la red del servidor Web) a una de ellas le asignaremos como nombre de red "Red 0" y a la otra "Red 1".

![configRed1_FirewallNorte](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed1_firewallNorte.png)

![configRed2_FirewallNorte](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed2_firewallNorte.png)

3) Seguiremos el proceso de instalación habitual de ubuntu, en éste caso sólo seleccionaremos como servicio extra el paquete SSH.


####Instalación Server-Web

**Pasos a seguir**

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservado dinamicamente.

2) En las configuraciones de red de la máquina dejaremos la red NAT configurada por defecto (para poder descargar posibles paquetes necesarios de internet) y añadiremos dos interfaces de red de tipo RED INTERNA (una que se conectará a la red del Firewall-Norte y otra que se conectará a la red del Firewall-Sur) a una de ellas le asignaremos como nombre de red "Red 1" y a la otra "Red 2".

![configRed1_ServerWeb](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed1_serverWeb.png)

![configRed2_ServerWeb](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed2_serverWeb.png)

3) Seguiremos el proceso de instalación habitual de ubuntu, en éste caso seleccionando las opciones de servicios adicionales: LAMP (Apache, Mysql, PHP), FTP y SSH.


####Instalación Server-App

**Pasos a seguir**

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservado dinamicamente.

2) En las configuraciones de red de la máquina dejaremos la red NAT configurada por defecto (para poder descargar posibles paquetes necesarios de internet) y añadiremos sólo una interfaz de red de tipo RED INTERNA (que se conectará a la red del Firewall-Sur) le asignaremos como nombre de red "Red 2". Éste servidor sólo tendrá una interfaz interna, porque sólo se podrá acceder desde la red corporativa.

![configRed_ServerApp](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed_serverApp.png)

3) Seguiremos el proceso de instalación habitual de ubuntu, en éste caso seleccionando las opciones de servicios adicionales: SSH. 

4) Una vez instalado el S.O procederemos a instalar el servicio de bases de datos Mysql.

![instalando_mysql](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerApp/instalandoMysql_ServerApp.png)


####Instalación Firewall-Sur

**Pasos a seguir**

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservado dinamicamente.

2) En las configuraciones de red de la máquina dejaremos la red NAT configurada por defecto (para poder descargar posibles paquetes necesarios de internet) y añadiremos dos interfaces de red de tipo RED INTERNA (una que se conectará a la red de los servidores y otra que se conectará a la red de el cliente de la empresa) a una de ellas le asignaremos como nombre de red "Red 2" y a la otra "Red 3".

![configRed1_FirewallSur](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed1_firewallSur.png)

![configRed2_FirewallSur](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed2_firewallSur.png)

3) Seguiremos el proceso de instalación habitual de ubuntu, en éste caso sólo seleccionaremos como servicio extra el paquete SSH.


####Instalación Empresa-Cliente

**Pasos a seguir**

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservado dinamicamente.

2) En las configuraciones de red de la máquina dejaremos la red NAT configurada por defecto (para poder descargar posibles paquetes necesarios de internet) y añadiremos otra interfaz de tipo RED INTERNA y asignandole como nombre de red "Red 3" que se conectará a la red del Firewall-Sur.

![configRed_empresaCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/configRed_empresaCliente.png)

3) Seguiremos el proceso de instalación habitual de ubuntu, sin instalar ningún tipo de servicio a parte.


###Configuración de las interfaces de red

Siguiendo el esquema que marcamos al principio se necesitarán 4 redes distintas que se estructurarán de la siguiente manera.

**Red 0**

Identificada por la dirección de red: 192.168.1.0

A ésta red pertenecen la máquina Internet-Cliente y una interfaz de la máquina Firewall-Norte.

**Red 1**

Identificada por la dirección de red: 172.16.2.0

A ésta red pertenecen la máquina Server-Web y una interfaz de la máquina Firewall-Norte.

**Red 2**

Identificada por la dirección de red: 172.16.3.0

A ésta red pertenecen la máquina Server-Web ,Server-App y una interfaz de la máquina Firewall-Sur.

**Red 3**

Identificada por la dirección de red: 192.168.2.0

A ésta red pertenecen la máquina Empresa-Cliente y una interfaz de la máquina Firewall-Sur.

A la hora de realizar la configuración de las direcciones en equipos que tengan dos tarjetas, debemos de prestar atención en asignar la dirección a la interfaz correcta. 

####Configuración de red Internet-Cliente

Editamos el fichero /etc/network/interfaces (los nombres de las interfaces de red pueden variar).

![config_internetCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/InternetCliente/configRed_internetCliente.png)

Reiniciamos el servicio ejecutando:

 > /etc/init.d/networking restart
 
Y comprobamos que los cambios se han realizado ejecutando "ifconfig".

![ifconfig_internetCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/InternetCliente/ifconfig_internetCliente.png)


####Configuración de red Firewall-Norte

Editamos el fichero /etc/network/interfaces (los nombres de las interfaces de red pueden variar).

![config_firewallNorte](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/FirewallNorte/configRed_firewallNorte.png)

Reiniciamos el servicio ejecutando:

 > /etc/init.d/networking restart
 
Y comprobamos que los cambios se han realizado ejecutando "ifconfig".

![ifconfig_firewallNorte](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/FirewallNorte/ifconfig_firewallNorte.png)


####Configuración de red Server-Web

Editamos el fichero /etc/network/interfaces (los nombres de las interfaces de red pueden variar).

![config_serverWeb](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerWeb/configuracionRed_ServerWeb.png)

Reiniciamos el servicio ejecutando:

 > /etc/init.d/networking restart
 
Y comprobamos que los cambios se han realizado ejecutando "ifconfig".

![ifconfig_serverWeb](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerWeb/ifconfig_ServerWeb.png)


####Configuración de red Server-App

Editamos el fichero /etc/network/interfaces (los nombres de las interfaces de red pueden variar).

![config_serverApp](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerApp/configuracionRed_ServerApp.png)

Reiniciamos el servicio ejecutando:

 > /etc/init.d/networking restart
 
Y comprobamos que los cambios se han realizado ejecutando "ifconfig".

![ifconfig_serverApp](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerApp/ifconfig_ServerApp.png)


####Configuración de red Firewall-Sur

Editamos el fichero /etc/network/interfaces (los nombres de las interfaces de red pueden variar).

![config_firewallSur](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/FirewallSur/configuracionRed_FirewallSur.png)

Reiniciamos el servicio ejecutando:

 > /etc/init.d/networking restart
 
Y comprobamos que los cambios se han realizado ejecutando "ifconfig".

![ifconfig_firewallSur](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/FirewallSur/ifconfig_FirewallSur.png)


####Configuración de red Empresa-Cliente

Editamos el fichero /etc/network/interfaces (los nombres de las interfaces de red pueden variar).

![config_empresaCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/EmpresaCliente/configRed_empresaCliente.png)

Reiniciamos el servicio ejecutando:

 > /etc/init.d/networking restart
 
Y comprobamos que los cambios se han realizado ejecutando "ifconfig".

![ifconfig_empresaCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/EmpresaCliente/ifconfig_empresaCliente.png)

Podemos comprobar que todo va bien haciendo ping entre los máquinas que estén conectadas a la misma red. Una vez comprobado, iremos un paso más allá y configuraremos los firewall para que enruten los paquetes y haya conectividad entre las redes que no sean contiguas como por ejemplo entre la máquina Internet-Cliente y Server-Web.


###Configuración y reglas de enrutamiento

A continuación ejecutaremos en las máquinas unas series de reglas que nos permitirán interconectar redes distintas, éstas reglas las definiremos en el fichero /etc/rc.local para que se ejecuten con el inicio de la máquina.

####Reglas Internet-Cliente

Con esa línea le estamos diciendo que para poder llegar a la red 172.16.2.0 tiene que ir a la puerta de enlace (Firewall-Norte) que es la máquina que funcionará como router y se encargará de reenviar nuestro paquete a su destino.

![rcLocal_internetCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/InternetCliente/rcLocal_internetCliente.png)


####Reglas Firewall-Norte

Añadimos la instrucción que hará que nuestro firewall actue como un router y nos permita interconectar las redes.

![rcLocal_firewallNorte](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/FirewallNorte/rcLocal_firewallNorte.png)


####Reglas Server-Web

Como en Internet-Cliente le decimos por dónde tiene que enviar los paquetes para poder comunicarse con la red 192.168.1.0 y 192.168.2.0.

![rcLocal_serverWeb](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerWeb/rc_local_ServerWeb.png)


####Reglas Server-App

En éste caso el servidor de aplicaciones sólo necesita comunicarse con la red 192.168.2.0 por lo que sólo le añadiremos una regla que enrute hacia esa red.

![rcLocal_serverApp](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/ServerApp/rc_local_ServerApp.png)


####Reglas Firewall-Sur

Al igual que en el Firewall-Norte sólo añadimos la instrucción que hará que nuestro firewall actue como un router y nos permita interconectar las redes.

![rcLocal_firewallSur](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/FirewallSur/rc_local_FirewallSur.png)


####Reglas Empresa-Cliente

Con esa línea le estamos diciendo que para poder llegar a la red 172.16.3.0 tiene que ir a la puerta de enlace (Firewall-Sur) que es la máquina que funcionará como router y se encargará de reenviar nuestro paquete a su destino.

![rcLocal_empresaCliente](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/EmpresaCliente/rcLocal_empresaCliente.png)

Una vez añadidas todas las reglas de enrutamiento podemos comprobar su funcionamiento haciendo un ping entre la máquina Internet-Cliente y Server-Web. Y otro entre la máquina Empresa-Cliente y Server-Web o Server-App. En cualquier caso si todo se ha realizado de forma correcta los ping nos devolverán una respuesta positiva.


###Configurando los Firewall's

Una vez está montada y conectada nuestro entorno de red nos queda lo más importante, protegerlo. Para ello debemos definir en las máquinas Firewall una serie de reglas que nos permita denegar el acceso a cualquier puerto o recurso que no hayamos aprobado.
Para conseguir esto haremos uso de IPTABLES, creaemos un script que ejecutaremos en las dos máquinas. Pues ambas van a compartir el mismo método de trabajo.

La política por defecto será la de denegar todo y configurar de forma individual lo que si queremos permitir. Por seguridad sólo permitiremos el acceso a los servicios web, ftp y ssh.

![iptables](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenes/iptables.png)

Una vez ejecutado el script en las dos máquinas Firewall (Firewall-Norte y Firewall-Sur) ya habríamos terminado de proteger nuestra red y para comprobarlo podemos usar algunas herramientas como nmap.


###Pruebas con NMAP

**¿Qué es NMAP?**

Nmap es un programa de código abierto que sirve para efectuar rastreo de puertos, se usa para evaluar la seguridad de sistemas informáticos, así como para descubrir servicios o servidores en una red informática.
Explora redes, determina el nombre del nodo y escanea puertos.

![nmap1](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenesPruebas/nmap_shark_serverWeb.png)

Como podemos observar, después de rastrear nuestro firewall sólo ha encontrado los que según nuestro script son los puertos permitidos.

![namp2](https://github.com/Ariacus/DMZ-Dual-Firewall/blob/master/imagenesPruebas/nmap-sA_shark_serverWeb.png)

con -sA se usan mensajes de ACK para lograr que el sistema responda y así determinar si el puerto esta abierto, algunos Firewall no filtran estos mensajes y por ello puede ser efectivo para comprobar el correcto funcionamiento. 
