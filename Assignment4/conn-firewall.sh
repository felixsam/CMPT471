#!/bin/bash

#Felix Sam
#conn-firewall.sh

#Connectivity Based Firewall
#Allows all packets to pass through but blocks ICMP Protocol type

#Clean Out Filter Rules
sudo iptables -F INPUT
sudo iptables -P INPUT ACCEPT
sudo iptables -F FORWARD
sudo iptables -P FORWARD ACCEPT
sudo iptables -F OUTPUT
sudo iptables -P OUTPUT ACCEPT

#Reject all packets of protocol type ICMP
sudo iptables -A INPUT -i eth1 -p icmp -j REJECT

#Run reset.sh to reset changes to firewall
