**Instalación Máquina Virtual**

Vamos a utilizar Ubuntu Server 12.04.05, para ello descargaremos VirtualBox de la página web oficial: https://www.virtualbox.org/wiki/Downloads

También deberemos descargar Ubuntu Server de la página oficial de Ubuntu: http://www.ubuntu.com/download/server

Una vez tengamos ambos, procederemos a instalar nuestro SO en la máquina virtual.

*Pasos a seguir*
 

1) Creamos la máquina virtual con 512MB de memoria y 8GB de disco reservador dinamicamente.

2) Una vez instalada la máquina virtual

Servidor Web: LAMP, FTP y SSH


Necesitaremos instalar un mínimo 6 máquinas virtuales, de las cuales habrá:

- 2 Firewall
- 1 Cliente simulado de la red externa
- 1 Servidor de Bases de Datos
- 1 Servidor de Aplicaciones
- 1 Servidor de Respaldo (opcional)
- 1 Máquina de la red interna


![](http://i.imgur.com/Gj6QjM3.png)


Una vez estemos instalando las máquinas, cuando nos aparezca esta pantalla deberemos de elegir unos programas u otros dependiendo de la máquina que sea:

- Los firewall necesitan instalar SSH
- El cliente de la red externa necesita FTP y SSH.
- El servidor de Bases de Datos PostgreSQL database, SSH y FTP.
- El servidor de aplicaciones LAMP, FTP y SSH.
- El servidor de respaldo LAMP,FTP, SSH y PostgreSQL database.
- La máquina de la red interna necesita FTP,SSH.



