#!/bin/bash

#Felix Sam
#res-firewall.sh

#Restrictive Based Firewall
#Blocks all packets except those with ICMP protocol

#Clean Out Filter Rules
sudo iptables -F INPUT
sudo iptables -P INPUT ACCEPT
sudo iptables -F FORWARD
sudo iptables -P FORWARD ACCEPT
sudo iptables -F OUTPUT
sudo iptables -P OUTPUT ACCEPT

#Blocks all packets except those with ICMP protocol
sudo iptables -A INPUT -i eth1 -p icmp -j ACCEPT
sudo iptables -A INPUT -i eth1 -j DROP

#Run reset.sh to reset changes to firewall