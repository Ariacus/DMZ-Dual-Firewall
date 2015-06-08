#!/bin/bash

#Flush de las reglas
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#Establecemos las politicas por defecto: Denegar
iptables -P INPUT DROP
iptables -P OUTUT DROP
iptables -P FORWARD DROP

#Todo paquete entrante se acepta para ese puerto y los salientes vinculados se aceptan
/sbin/iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp -m tcp --sport 80 -m state --state RELATED, ESTABLISHED -j ACCEPT

#Regla necesaria para FTP pasivo y activo
/sbin/iptables -A INPUT -p tcp -m tcp --sport 20:21 -m state --state RELATED, ESTABLISHED -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp -m tcp --dport 20:21 -j ACCEPT

#Regla necesaria para SSH
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -A OUTPUT -p udp --sport 22 -j ACCEPT
