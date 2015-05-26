1. Creación de una máquina ubuntu server limpia, que nos servirá de base para crear el resto. 
Como paquete extra se instalará sel servicio ssh.

2. Configuración de las interfaces de red correspondientes (según el rol) a cada máquina. 
Desde virtualbox utilizaremos los adaptadores en modo Red Interna y se crearan 4 nombres de subredes
de forma que los adaptadores de cada equipo posean el nombre a la red correspondiente.

							Internet-Cliente1 
										 (Red0/eth0)
									|	(192.168.1.1)
									|
									|
									|	(192.168.1.254)
										(Red0/eth0)
							Firewall-Norte 
										(Red1/eth1)
									|	(172.16.2.254)
									|
									|
									|
		------------------------------------------
		|		
		|	(172.16.2.1)									
			(Red1/eth0)							
Server-Web1								Server-App1	
			(Red2/eth1)								(Red2/eth1)	
		|	(172.16.3.1)							|	(172.16.3.2)
		|											|
		-------------------------------------------------------------------
							|
							|
							|	
									(172.16.3.254)
									(Red2/eth0)
						Firewall-Sur
									(Red3/eth1)
							|		(192.168.2.254)
							|
							|
							|		(192.168.2.1)
									(Red3/eth0)
					Empresa-Cliente1

Una vez configurada cada máquina virtual, tendremos que configurar en cada una las interfaces con sus correspondientes
direcciones ip.

3. Para comprobar la conectividad tendremos que definir unas reglas de enrutamiento en cada máquina. Para que éstas
reglas se mantengan en caso de reinicio, sería conveniente añadirlas al fichero /etc/rc.local.

Internet-Cliente1 
	route add -net 172.16.2.0 netmask 255.255.255.0 gw 192.168.1.254

Firewall-Norte
	echo 1 > /proc/sys/net/ipv4/ip_forward (Para que actúe como router)

Server-Web1
	route add -net 192.168.1.0 netmask 255.255.255.0 gw 172.16.2.254
	route add -net 192.168.2.0 netmask 255.255.255.0 gw 172.16.3.254

Server-App1
	route add -net 192.168.2.0 netmask 255.255.255.0 gw 172.16.3.254

Firewall-Sur
	echo 1 > /proc/sys/net/ipv4/ip_forward (Para que actúe como router)

Empresa-Cliente1
	route add -net 172.16.3.0 netmask 255.255.255.0 gw 192.168.2.254

4. Una vez comprobada la conectividad entre todos los nodos, configuraremos las máquinas Firewall (tanto Norte
como Sur) añadiendo las reglas que impediran el paso de ciertos tipos de paquetes y de ciertas redes.

5. Configurar la máquina servidor web como tal, instalandole apache, mysql...
