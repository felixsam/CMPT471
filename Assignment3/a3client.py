#Felix Sam
#CMPT 471 Assignment 3 Part 1
#a3client.py

import sys
import socket

#Host is April
HOST = '172.16.1.4'
#Port is 9999
PORT = 9999

#Create a TCP/IP socket
client = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

#Connection establishment
print 'Connection establishment'
client.connect((HOST,PORT))

#Send a message to the server
print 'Sending Test Message to Server'
client.send('Test Message')

#Received the data from the server
data = client.recv(1024)
print 'Received', repr(data)

#Close the connection
print 'Closing connection'
client.close()