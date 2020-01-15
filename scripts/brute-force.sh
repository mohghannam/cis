#!/bin/bash
#

#for the first time 



password_file=~/password_file
ips_file=~/hosts


for passwd in $(cat $password_file) 
do
  for host in $(cat $ips_file)
  do
     ./script.py $passwd $host 
     if [ $? -eq 0 ];then
        echo "the password for $host is:  $passwd" 
     fi
  done
done
     
     
