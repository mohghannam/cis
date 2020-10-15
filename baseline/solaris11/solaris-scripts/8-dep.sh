#!/bin/bash

	#8.1 Create Warnings for Standard Login Services
		cp -p /etc/motd   /etc/motd.bkp 
		cp -p /etc/issue  /etc/issue.bkp 2> /dev/null 
		echo "Authorized users only. All activity may be monitored and reported." > /etc/motd 
		echo "Authorized users only. All activity may be monitored and reported." > /etc/issue
		chown root:root /etc/issue /etc/motd
		chmod 644 /etc/issue /etc/motd
		
	#8.2 Enable a Warning Banner for the SSH Service
	
		awk '/^#Banner/ { $1 = "Banner" }  { print }' /etc/ssh/sshd_config > /etc/ssh/sshd_config.CIS 
		mv /etc/ssh/sshd_config.CIS /etc/ssh/sshd_config 
		svcadm restart svc:/network/ssh
		
	#8.5 Check that the Banner Setting for telnet is Null
		cp -p /etc/default/telnetd /etc/default/telnetd.CIS
		awk '/^BANNER=/ { $1 = "BANNER=" }; { print }'  /etc/default/telnetd > /etc/default/telnetd.CIS 
		mv /etc/default/telnetd.CIS /etc/default/telnetd
