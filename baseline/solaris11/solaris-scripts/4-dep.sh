#!/bin/bash

#3- Audit

	#3.1 Add Audit class  cis

		cp -p /etc/security/audit_class /etc/security/audit_class.bkp
sed '67a\
0x0100000000000000:cis:CIS Solaris Benchmark'  /etc/security/audit_class >> /etc/security/audit_class.tmp
		cp -p /etc/security/audit_class.tmp /etc/security/audit_class
		chown root:sys /etc/security/audit_class
		
		
	#3.2 Enable Auditing of Incoming Network Connections
		
		cp -p /etc/security/audit_event /etc/security/audit_event.bkp
		
		num=$(grep -n "AUE_ACCEPT" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event   >> /etc/security/audit_event.1
		
		num=$(grep -n "AUE_CONNECT" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.1 >> /etc/security/audit_event.2
		
		num=$(grep -n "AUE_SOCKACCEPT" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.2 >> /etc/security/audit_event.3
		
		num=$(grep -n "AUE_SOCKCONNECT" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.3 >> /etc/security/audit_event.4
		
		num=$(grep -n "AUE_inetd_connect" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.4 >> /etc/security/audit_event.5

		
		
	#3.3 Enable Auditing of File Metadata Modification Events
	
		num=$(grep -n "AUE_CHMOD" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.5   >> /etc/security/audit_event.6
		
		num=$(grep -n "AUE_CHOWN" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.6 >> /etc/security/audit_event.7
		
		num=$(grep -n "AUE_FCHOWN:" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.7 >> /etc/security/audit_event.8
		
		num=$(grep -n "AUE_FCHMOD" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.8 >> /etc/security/audit_event.9
		
		num=$(grep -n "AUE_LCHOWN" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.9 >> /etc/security/audit_event.10
		
		num=$(grep -n "AUE_ACLSET" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.10 >> /etc/security/audit_event.11
		
		num=$(grep -n "AUE_FACLSET" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.11 >> /etc/security/audit_event.12
		
		
		
		
	#3.4 Enable Auditing of Process and Privilege Events
	
		num=$(grep -n "AUE_CHROOT" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.12   >> /etc/security/audit_event.13
		
		num=$(grep -n "AUE_SETREUID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.13 >>   /etc/security/audit_event.14
		
		num=$(grep -n "AUE_SETREGID:" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.14 >>	   /etc/security/audit_event.15
		
		num=$(grep -n "AUE_FCHROOT" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.15 >> /etc/security/audit_event.16
		
		num=$(grep -n "AUE_PFEXEC" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.16 >> /etc/security/audit_event.17
		
		num=$(grep -n "AUE_SETUID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.17 >> /etc/security/audit_event.18
		
		num=$(grep -n "AUE_NICE" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.18 >> /etc/security/audit_event.19
		
		num=$(grep -n "AUE_SETGID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.19 >> /etc/security/audit_event.20
		
		num=$(grep -n "AUE_PRIOCNTLSYS" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.20 >> /etc/security/audit_event.21
		
		num=$(grep -n "AUE_SETEGID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.21 >> /etc/security/audit_event.22
		
		num=$(grep -n "AUE_SETEUID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.22 >> /etc/security/audit_event.23
		
		num=$(grep -n "AUE_SETPPRIV" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.23 >> /etc/security/audit_event.24
		
		num=$(grep -n "AUE_SETSID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.24 >> /etc/security/audit_event.25
		
		num=$(grep -n "AUE_SETPGID" /etc/security/audit_event | cut -d: -f -1)
		sed -e $num's/$/&,cis/' /etc/security/audit_event.25 >> /etc/security/audit_event.26
		
		
		
		cp  /etc/security/audit_event.26 /etc/security/audit_event
		chown root:sys /etc/security/audit_event
		rm /etc/security/audit_event.1*
		rm /etc/security/audit_event.2*
		rm /etc/security/audit_event.3 /etc/security/audit_event.4 /etc/security/audit_event.5 /etc/security/audit_event.6 /etc/security/audit_event.7 /etc/security/audit_event.8 /etc/security/audit_event.9
	
	
	#3.5 Configure Solaris Auditing
		
		auditconfig -conf
		auditconfig -setflags lo,ad,ft,ex,cis
		auditconfig -setnaflags lo
		auditconfig -setpolicy cnt,argv,zonename
		auditconfig -setplugin audit_binfile active p_minfree=1
		audit -s
		usermod -K audit_flags=lo,ad,ft,ex,cis:no root
		echo "0 * * * * /usr/sbin/audit -n" >> /var/spool/cron/crontabs/root
		chown root:root /var/share/audit
		chmod 750 /var/share/audit
		chown root:root /var/audit
                chmod 750 /var/audit
