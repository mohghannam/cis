#!/bin/bash
grep "MAXWEEKS=" /etc/default/passwd

grep "MINWEEKS=" /etc/default/passwd 
grep "WARNWEEKS=" /etc/default/passwd
grep "^RETRIES" /etc/default/login
grep "^LOCK_AFTER_RETRIES" /etc/security/policy.conf

grep "^NAMECHECK=" /etc/default/passwd
grep "^HISTORY=" /etc/default/passwd
grep "^MINSPECIAL=" /etc/default/passwd
grep "^MINLOWER=" /etc/default/passwd
grep "^MINDIGIT=" /etc/default/passwd
grep "^MINUPPER=" /etc/default/passwd
grep "^PASSLENGTH=" /etc/default/passwd

grep CRYPT_DEFAULT /etc/security/policy.conf
grep CRYPT_ALGORITHMS_ALLOW /etc/security/policy.conf

svcs -Ho state svc:/network/ftp

svcs -Ho state svc:/network/telnet

svcs -Ho state svc:/network/tftp/udp6

grep "^Protocol" /etc/ssh/sshd_config

grep "^MaxAuthTries" /etc/ssh/sshd_config

grep "^IgnoreRhosts" /etc/ssh/sshd_config

grep "^HostbasedAuthentication" /etc/ssh/sshd_config

grep "^PermitEmptyPasswords" /etc/ssh/sshd_config

grep "^PermitRootLogin" /etc/ssh/sshd_config



cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }'

