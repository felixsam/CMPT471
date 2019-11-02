#!/bin/bash

#Felix Sam
#reset.sh

#Reset firewall rules to default

#Clean Out Filter Rules
sudo iptables -F INPUT
sudo iptables -P INPUT ACCEPT
sudo iptables -F FORWARD
sudo iptables -P FORWARD ACCEPT
sudo iptables -F OUTPUT
sudo iptables -P OUTPUT ACCEPT