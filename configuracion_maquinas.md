##Configuración de las Máquinas Virtuales

**Configuración Firewall Sur:**

La máquina virtual que desempeña el papel de Firewall sur tiene la siguiente configuración de red en su archivo /etc/network/interfaces:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/FirewallSur/configuracionRed_FirewallSur.png?raw=true) 

Lo comprobamos ejecutando ifconfig:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/FirewallSur/ifconfig_FirewallSur.png?raw=true)


Seria interesante instalar ssh en la máquina para realizar tareas de administración:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/FirewallSur/rc_local_FirewallSur.png?raw=true)

Para que la máquina funcione como router es necesario ejecutar el siguiente comando y para automatizar el proceso al reiniciarla, es conveniente editar el fichero /etc/rc.local y dejarlo como se muestra en la siguiente figura:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/FirewallSur/rc_local_FirewallSur.png?raw=true)

**Configuración ServerAPP**

La máquina que desempeña el papel de servidor de aplicación tiene la siguiente configuración de red en su archivo /etc/network/interfaces:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerApp/configuracionRed_ServerApp.png?raw=true)

lo comprobamos ejecutando ifconfig:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerApp/ifconfig_ServerApp.png?raw=true)


Añadir aquí las nuevas capturas para mysql

Para indicarle al servidor la red y su defaul gateway de manera automática al inicio de la máquina, es necesario editar el archivo /etc/rc.local y dejarlo como esta en la siguiente figura:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerApp/ifconfig_ServerApp.png?raw=true)

**Configuración ServerWeb**

La máquina que desempeña el papel de servidor web tiene la siguiente configuración en su archivo /etc/network/interfaces:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/configuracionRed_ServerWeb.png?raw=true)

lo comprobamos con ifconfig:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/ifconfig_ServerWeb.png?raw=true)

En esta máquina, instalamos un servidor LAMP mediante los siguientes comandos:
- apache2

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/instalacionApache2_ServerWeb.png?raw=true)

- MYSQL

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/instalacionMYSQL_ServerWeb.png?raw=true)

- PHP5

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/instalacionPHP5_ServerWeb.png?raw=true)


También es interesante la instalación de ssh y el servidor ftp:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/instalacionSSH_ServerWeb.png?raw=true)
![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/instalacionVSFTPD_ServerWeb.png?raw=true)

Finalmente para automatizar el proceso de configuración de las redes, editamos el archivo /etc/rc.local y lo dejamos como se muestra en la figura:

![imagen](https://github.com/hugobarzano/DMZ-Dual-Firewall/blob/master/ServerWeb/rc_local_ServerWeb.png?raw=true)












