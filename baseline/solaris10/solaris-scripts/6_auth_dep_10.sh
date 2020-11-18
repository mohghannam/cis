#!/bin/bash

# 6 System Access, Authentication, and Authorization
date=`date +%y%m%d`
	#6.1 Configure SSH
		. ./6_sub_ssh.sh
		
		
		
	#6.2 Disable login: Prompts on Serial Ports
		pmadm -L | awk -F: '($4 == "ux") { print $3 }' | grep ttya
		x=$(echo $?)
		if [[ $x == 1 ]]
		then
			pmadm -d -p zsmon -s ttya
			pmadm -d -p zsmon -s ttyb
		else
			pmadm -L | awk -F: '($4 == "ux") { print $3 }' >> /CIS_vod_sol10/variables_pmadm.txt
		fi
		
		
	#6.3 Disable "nobody" Access for RPC Encryption Key Storage Service
		cp -p  /etc/default/keyserv  /etc/default/keyserv.bkp.$date
		awk '/ENABLE_NOBODY_KEYS=/ \
		{ $1 = "ENABLE_NOBODY_KEYS=NO" } { print }' /etc/default/keyserv > /etc/default/keyserv.new 
		mv /etc/default/keyserv.new  /etc/default/keyserv
		pkgchk -f -n -p /etc/default/keyserv
		
	
	
	
	#6.4 Disable .rhosts Support in /etc/pam.conf	
		cp -p /etc/pam.conf /etc/pam.conf.bkp.$date 
		sed -e 's/^.*pam_rhosts_auth/#&/' < /etc/pam.conf > /etc/pam.conf.new 
		mv /etc/pam.conf.new /etc/pam.conf 
		pkgchk -f -n -p /etc/pam.conf
		
	

	
	#6.5 Restrict FTP Use 
		for user in `awk -F: '{ print $1 }' /etc/passwd`
		do 
			grep -w "${user}" /etc/ftpd/ftpusers > /dev/null 2>&1
			if [ $? != 0 ]
			then 
				echo "User ${user} not in /etc/ftpd/ftpusers." >> /CIS_vod_sol10/variables_ftp.txt
			fi 
		done
		
		cp -p /etc/ftpd/ftpusers /etc/ftpd/ftpusers.bkp.$date
		for user in adm bin daemon gdm listen lp noaccess nobody nobody4 nuucp postgres root smmsp svctag sys uucp webservd 
		do 
			echo $user >> /etc/ftpd/ftpusers 
		done 
		sort -u /etc/ftpd/ftpusers > /etc/ftpd/ftpusers.new
		mv /etc/ftpd/ftpusers.new /etc/ftpd/ftpusers
		pkgchk -f -n -p /etc/ftpd/ftpusers
		
		
	#6.6 Set Delay between Failed Login Attempts to 4
		cp -p /etc/default/login /etc/default/login.bkp.$date
		awk '/SLEEPTIME=/ { $1 = "SLEEPTIME=4" } { print }' /etc/default/login > /etc/default/login.new 
		mv /etc/default/login.new /etc/default/login #
		pkgchk -f -n -p /etc/default/login
		
		
		
	#6.7 Set Default Screen Lock for CDE Users	
		for file in /usr/dt/config/*/sys.resources
		do 
			dir=`dirname $file | sed s/usr/etc/`
			 
			mkdir -m 755 -p $dir
			echo 'dtsession*saverTimeout: 10' >> $dir/sys.resources 
			echo 'dtsession*lockTimeout: 10' >> $dir/sys.resources 
			chown root:sys $dir/sys.resources 
			chmod 444 $dir/sys.resources 
		done



		
	#6.8 Set Default Screen Lock for GNOME Users
		cp -p /usr/openwin/lib/app-defaults/XScreenSaver /usr/openwin/lib/app-defaults/XScreenSaver.bkp.$date
		awk '/^\*timeout:/ { $2 = "0:10:00" } /^\*lockTimeout:/ { $2 = "0:00:00" } /^\*lock:/ { $2 = "True" } { print }' /usr/openwin/lib/app-defaults/XScreenSaver > /usr/openwin/lib/app-defaults/XScreenSaver.new
		mv /usr/openwin/lib/app-defaults/XScreenSaver.new /usr/openwin/lib/app-defaults/XScreenSaver
		pkgchk -f -n -p /usr/openwin/lib/app-defaults/XScreenSaver
		


		
	#6.9 Restrict at/cron to Authorized Users
		cp -p /etc/cron.d/cron.deny /etc/cron.d/cron.deny.bkp.$date
		cp -p /etc/cron.d/at.deny /etc/cron.d/at.deny.bkp.$date
		cp -p /etc/cron.d/cron.allow /etc/cron.d/cron.allow.bkp.$date
		cp -p /etc/cron.d/at.allow /etc/cron.d/at.allow.bkp.$date 
		
		mv /etc/cron.d/cron.deny /etc/cron.d/cron.deny.cis 
		mv /etc/cron.d/at.deny /etc/cron.d/at.deny.cis 
		echo root > /etc/cron.d/cron.allow 
		cp /dev/null /etc/cron.d/at.allow 
		chown root:root /etc/cron.d/cron.allow /etc/cron.d/at.allow 
		chmod 400 /etc/cron.d/cron.allow /etc/cron.d/at.allow
		


		
	#6.10 Restrict root Login to System Console	
		awk '/CONSOLE=/ { print "CONSOLE=/dev/console"; next };  { print }' /etc/default/login > /etc/default/login.new 
		mv /etc/default/login.new /etc/default/login 
		pkgchk -f -n -p /etc/default/login
		
		
		
	#6.11 Set Retry Limit for Account Lockout
		cp -p /etc/security/policy.conf /etc/security/policy.conf.bkp.$date
		
		awk '/RETRIES=/ { $1 = "RETRIES=3" } { print }' /etc/default/login > /etc/default/login.new 
		mv /etc/default/login.new /etc/default/login 
		pkgchk -f -n -p /etc/default/login 
		
		awk '/LOCK_AFTER_RETRIES=/  { $1 = "LOCK_AFTER_RETRIES=YES" } { print }' /etc/security/policy.conf > /etc/security/policy.conf.new 
		mv /etc/security/policy.conf.new /etc/security/policy.conf 
		pkgchk -f -n -p /etc/security/policy.conf
		usermod -K lock_after_retries=no oracle
		
		
		
		