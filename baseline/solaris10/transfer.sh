#!/bin/bash

sol_ip=$1

#scp dir root@$1  

scripts=/var/lib/awx/projects/CIS_Hardening_solaris/solaris10/solaris-scripts


#sshpass -p 'password' scp file.tar.gz root@xxx.xxx.xxx.194:/backup 

scp -r $scripts  root@$sol_ip:/root/cis
