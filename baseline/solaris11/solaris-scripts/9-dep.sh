#!/bin/bash

	#9 System Maintenance
	
	# 9.2 Verify System File Permissions
	
	#9.3 Verify System Account Default Passwords
	
		. ./users_to_lock.sh | awk '{ print $2}' >> /cis-vod-sol11/user_to_lock.txt
		. ./users_to_nologin.sh | awk '{ print $2}' >> /cis-vod-sol11/user_to_nologin.txt
		
		while IFS= read -r line
do
		passwd -d $line 
		passwd -l $line	
		
done < /cis-vod-sol11/user_to_lock.txt
		
		while IFS= read -r line
do
		passwd -d $line 
		passwd -N $line	
		
done < /cis-vod-sol11/user_to_nologin.txt


	#9.4 Ensure Password Fields are Not Empty
	
	
	
	
	
	
for dir in `logins -ox | awk -F: '($8 == "PS") { print $6 }'`; do
 find ${dir} -type d -prune \( -perm -g+w -o  -perm -o+r -o -perm -o+w -o -perm -o+x \) -ls
 done
 
 for dir in  `logins -ox | awk -F: '($8 == "PS") { print $6 }'`; do
 find ${dir}/.[A-Za-z0-9]* \! -type l  \( -perm -20 -o -perm -02 \) -ls
 done
 
 logins -xo | while read line; do
 user=`echo ${line} | awk -F: '{ print $1 }'` 
 home=`echo ${line} | awk -F: '{ print $6 }'` 
 if [ ! -d "${home}" ]; then echo ${user} 
 fi 
 done
 
 getent group | cut -f3 -d":" | sort -n | uniq -c |
 while read x ; do 
 [ -z "${x}" ] && break
 set - $x 
 if [ $1 -gt 1 ]; then
 grps=`getent group | nawk -F: '($3 == n) { print $1 }' n=$2 | xargs`
 echo "Duplicate GID ($2): ${grps}" 
 fi 
 done
 
 logins -so | awk -F: '{ print $1 }' | while read user; do 
 found=0 
 for tUser in adm aiuser bin daemon dhcpserv dladm ftp gdm listen lp mysql netadm netcfg noaccess  nobody nobody4 nuucp openldap pkg5srv postgres  root smmsp svctag sys unknown uucp upnp  webservd xvm zfssnap; do 
if [ ${user} = ${tUser} ]; then 
found=1 
fi 
done
 if [ $found -eq 0 ]; then
 echo "Invalid User with Reserved UID: ${user}"
 fi 
 done
	
