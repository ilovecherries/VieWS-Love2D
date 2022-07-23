import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("10.0.0.155", 1324))
s.send(str.encode("print('good morning!')\n"))
msg = s.recv(1024)
s.close()