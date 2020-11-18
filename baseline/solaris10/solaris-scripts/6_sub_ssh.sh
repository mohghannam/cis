#!/sbin/bash 
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp.$date

/usr/bin/awk '/^Protocol/ { $2 = "2" }; \
/^X11Forwarding/ { $2 = "no" }; \
/^MaxAuthTries/ { $2 = "3" }; \
/^MaxAuthTriesLog/ { $2 = "0" }; \
/^IgnoreRhosts/ { $2 = "yes" }; \
/^RhostsAuthentication/ { $2 = "no" }; \
/^RhostsRSAAuthentication/ { $2 = "no" }; \
/^PermitRootLogin/ { $2 = "no" }; \
/^PermitEmptyPasswords/ { $2 = "no" }; \
/^#Banner/ { $1 = "Banner" } \
{ print }' /etc/ssh/sshd_config > /etc/ssh/sshd_config.new 
/usr/bin/mv /etc/ssh/sshd_config.new /etc/ssh/sshd_config 
/usr/sbin/pkgchk -f -n -p /etc/ssh/sshd_config 
/usr/sbin/svcadm restart svc:/network/ssh