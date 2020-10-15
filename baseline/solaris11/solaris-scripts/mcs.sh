#!/bin/bash

########################### 1 ##################################
chmod 400 /etc/shadow
chown root:root /etc/shadow

########################### 2 ##################################
chmod 644 /etc/passwd
chown root:root /etc/passwd

########################### 3 ##################################
chmod 644 /etc/group
chown root:root /etc/group

########################### 4 ##################################
chmod 0600 /etc/ssh/sshd_config
chown root:root /etc/ssh/sshd_config

########################### 5 ##################################
logins -p 

########################### 17 ##################################
cp -p /etc/security/policy.conf  /etc/security/policy.conf.bkp
awk '/^CRYPT_DEFAULT/ { $1 = "CRYPT_DEFAULT=6" }; /^CRYPT_ALGORITHMS_ALLOW/ { $1 = "CRYPT_ALGORITHMS_ALLOW=6" }; { print }' /etc/security/policy.conf  >> /etc/security/policy.conf.CIS 
mv /etc/security/policy.conf.CIS /etc/security/policy.conf

########################### 20 ##################################
FILE=/etc/ssh/sshd_config.bkp
if test -f "$FILE"; then
    echo "$FILE exists."
else
	cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp 
fi

echo "Protocol 2" >> /etc/ssh/sshd_config
echo "HostbasedAuthentication no" >>  /etc/ssh/sshd_config

svcadm refresh ssh
svcadm restart ssh 

############################ 21 #################################




############################ 27 #################################
/bin/cat /etc/group | /bin/cut -f3 -d":" | /bin/sort -n | /usr/bin/uniq -c | while read x ; do
 [ -z "${x}" ] && break
 set - $x
 if [ $1 -gt 1 ]; then
  grps=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2  /etc/group | xargs`
  echo "Duplicate GID ($2): ${grps}"
 fi 
done

############################ 28 ################################
cat  /etc/passwd | /bin/cut -f3 -d":" | /bin/sort -n | /usr/bin/uniq -c |while read x ; do
 [ -z "${x}" ] && break
 set - $x
 if [ $1 -gt 1 ]; then
  users=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2  /etc/passwd | /usr/bin/xargs`
  echo "Duplicate UID ($2): ${users}"
 fi
done





## 6-  grep "MAXWEEKS=" /etc/default/passwd 
## 
## 7-  grep "MINWEEKS=" /etc/default/passwd 1
## 8-  grep "WARNWEEKS=" /etc/default/passwd 
## 9-  grep "^RETRIES" /etc/default/login 
## RETRIES=5 
## # grep "^LOCK_AFTER_RETRIES" /etc/security/policy.conf 
## LOCK_AFTER_RETRIES=YES
## 
## 10- grep "^NAMECHECK=" /etc/default/passwd
## 11- grep "^HISTORY=" /etc/default/passwd
## 12- grep "^MINSPECIAL=" /etc/default/passwd
## 13- grep "^MINLOWER=" /etc/default/passwd
## 14- grep "^MINDIGIT=" /etc/default/passwd
## 15- grep "^MINUPPER=" /etc/default/passwd
## 16- grep "^PASSLENGTH=" /etc/default/passwd
##   
## 17- grep CRYPT_DEFAULT /etc/security/policy.conf 
##     grep CRYPT_ALGORITHMS_ALLOW /etc/security/policy.conf 
##    
## 18- svcs -Ho state svc:/network/ftp
## 
## 19- svcs -Ho state svc:/network/telnet
## 
## 20- svcs -Ho state svc:/network/tftp/udp6
## 
## 21- grep "^Protocol" /etc/ssh/sshd_config 
## 
## 22- grep "^MaxAuthTries" /etc/ssh/sshd_config
## 
## 23- grep "^IgnoreRhosts" /etc/ssh/sshd_config
## 
## 24- grep "^HostbasedAuthentication" /etc/ssh/sshd_config
## 
## 25- grep "^PermitEmptyPasswords" /etc/ssh/sshd_config 
## 
## 26- grep "^PermitRootLogin" /etc/ssh/sshd_config 
## 
## 
## 27- 
## 29- cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' 
## 
