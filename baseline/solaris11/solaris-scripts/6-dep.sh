#!/bin/bash



	#6.1- Disable login: Services on Serial Ports 
		svcadm disable svc:/system/console-login:terma
		svcadm disable svc:/system/console-login:termb

		echo "$(date)             ----- info ----              svc:/system/console-login:terma disabled   " >> /cis-vod-sol11/log/cis.log
		echo "$(date)             ----- info ----              svc:/system/console-login:termb disabled   " >> /cis-vod-sol11/log/cis.log
		



	#6.2- Disable "nobody" Access for RPC Encryption Key Storage Service 
		
		grep "^ENABLE_NOBODY_KEYS=" /etc/default/keyserv
		check=$(echo $?)
		cp -p /etc/default/keyserv /etc/default/keyserv.bkp
		cp -p /etc/default/keyserv.bkp /etc/default/keyserv.cis
		if [ $check -eq 0 ]; then
        		awk '/ENABLE_NOBODY_KEYS=/  { $1 = "ENABLE_NOBODY_KEYS=NO" } { print }' /etc/default/keyserv  >  /etc/default/keyserv.cis
        		mv /etc/default/keyserv.cis /etc/default/keyserv
		else
       			echo "ENABLE_NOBODY_KEYS=NO" >> /etc/default/keyserv
		fi

		echo "$(date)             ----- info ----              Disable nobody Access for RPC Encryption Key Storage Service   " >> /cis-vod-sol11/log/cis.log

	#6.3-  Disable X11 Forwarding 
		grep  "^X11Forwarding" /etc/ssh/sshd_config
		check=$(echo $?)
		cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp
		cp -p  /etc/ssh/sshd_config.bkp /etc/ssh/sshd_config.cis
		if [ $check -eq 0 ]; then
        		awk '/X11Forwarding/  { $2 = "no" } { print }' /etc/ssh/sshd_config  >  /etc/ssh/sshd_config.cis
        		mv  /etc/ssh/sshd_config.cis /etc/ssh/sshd_config
				svcadm restart svc:/network/ssh

		fi

		echo "$(date)             ----- info ----              Disable X11 Forwarding   " >> /cis-vod-sol11/log/cis.log


	#6.4- Limit Consecutive Login Attempts for SSH to 3 
		awk '/MaxAuthTries/  { $1 = "MaxAuthTries"} { print }' /etc/ssh/sshd_config  >  /etc/ssh/sshd_config.cis
		awk '/MaxAuthTries/  { $2 = 5 } { print }' /etc/ssh/sshd_config.cis  >  /etc/ssh/sshd_config
		svcadm restart ssh

		echo "$(date)             ----- info ----              Limit Consecutive Login Attempts for SSH to 3   " >> /cis-vod-sol11/log/cis.log


	#6.5 Disable Rhost based Authentication for SSH
		awk '/^IgnoreRhosts/ { $2 = "yes" } { print }' /etc/ssh/sshd_config > /etc/ssh/sshd_config.CIS
		if [ $? == 0 ]; then
			mv /etc/ssh/sshd_config.CIS /etc/ssh/sshd_config 
		fi
		svcadm restart svc:/network/ssh
		svcadm refresh svc:/network/ssh
		

	#6.6- disable root login SSH 
		awk '/^PermitRootLogin/ { $2 = "no" }  { print }' /etc/ssh/sshd_config > /etc/ssh/sshd_config.cis
		mv  /etc/ssh/sshd_config.cis /etc/ssh/sshd_config
		svcadm restart ssh

		echo "$(date)             ----- info ----              root login disabled over SSH    " >> /cis-vod-sol11/log/cis.log


	#6.7-  disable empty password login ssh 
		awk '/^PermitEmptyPasswords/ { $2 = "no" }  { print }' /etc/ssh/sshd_config > /etc/ssh/sshd_config.CIS
		mv /etc/ssh/sshd_config.CIS /etc/ssh/sshd_config
		svcadm restart ssh

		echo "$(date)             ----- info ----              disable empty password login ssh    " >> /cis-vod-sol11/log/cis.log


	#6.8 Disable Host based Authentication for Login based Services
		cp -p /etc/pam.conf /etc/pam.conf.bkp
		cp -p /etc/pam.d/rlogin /etc/pam.d/rlogin.bkp
		cp -p /etc/pam.d/rsh /etc/pam.d/rsh.bkp
		
		sed '/pam_rhosts_auth/d' /etc/pam.conf > /etc/pam.conf.cis
		sed '/pam_rhosts_auth/d' /etc/pam.d/rlogin > /etc/pam.d/rlogin.cis
		sed '/pam_rhosts_auth/d' /etc/pam.d/rsh > /etc/pam.d/rsh.cis
		
		mv /etc/pam.conf.cis /etc/pam.conf
		mv /etc/pam.d/rlogin.cis /etc/pam.d/rlogin
		mv /etc/pam.d/rsh.cis /etc/pam.d/rsh
		
		
		
	#6.9-   Restrict FTP Use
		cp -p /etc/ftpd/ftpusers /etc/ftpd/ftpusers.bkp

		for user in `logins -s | awk '{ print $1 }'`  aiuser noaccess nobody nobody4; do
		        grep -w "${user}" /etc/ftpd/ftpusers >/dev/null 2>&1
        		if [ $? != 0 ]; then
                		echo $user >> /etc/ftpd/ftpusers
        		fi
		done

		echo "$(date)             ----- info ----              FTP Use restricted     " >> /cis-vod-sol11/log/cis.log
		
	#6.10- Set Delay between Failed Login Attempts to 4
		cp -p /etc/default/login /etc/default/login.bkp 
		awk '/SLEEPTIME=/ { $1 = "SLEEPTIME=4" } { print }' /etc/default/login > /etc/default/login.CIS
		mv /etc/default/login.CIS /etc/default/login

		echo "$(date)             ----- info ----               Set Delay between Failed Login Attempts to 4     " >> /cis-vod-sol11/log/cis.log

	#6.13- Restrict at/cron to Authorized Users
	
		ls -l /etc/cron.d/ >> /etc/cron.d/output.txt
		mv /etc/cron.d/cron.deny /etc/cron.d/cron.deny.cis
		mv /etc/cron.d/at.deny /etc/cron.d/at.deny.cis
		echo root > /etc/cron.d/cron.allow
		cp /dev/null /etc/cron.d/at.allow
		chown root:root /etc/cron.d/cron.allow /etc/cron.d/at.allow
		chmod 400 /etc/cron.d/cron.allow /etc/cron.d/at.allow
		
	#6.15- Set Retry Limit for Account Lockout to 3

		cp -p /etc/default/login /etc/default/login.bkp
		cp -p /etc/default/login.bkp /etc/default/login.CIS
		awk '/RETRIES=/ { $1 = "RETRIES=5" } { print }' /etc/default/login > /etc/default/login.CIS 
		mv /etc/default/login.CIS /etc/default/login 

		cp -p /etc/security/policy.conf /etc/security/policy.conf.bkp
		cp -p /etc/security/policy.conf /etc/security/policy.conf.CIS
		awk '/LOCK_AFTER_RETRIES=/  { $1 = "LOCK_AFTER_RETRIES=YES" } { print }' /etc/security/policy.conf > /etc/security/policy.conf.CIS 
		mv /etc/security/policy.conf.CIS  /etc/security/policy.conf

		echo "$(date)             ----- info ----               Set Retry Limit for Account Lockout to 5     " >> /cis-vod-sol11/log/cis.log

	#6.16

		
		eeprom security-mode=command 
		eeprom security-#badlogins=0


	#6.17- Secure the GRUB Menu (Intel)
		
		

		
