#!/bin/bash
###################################################### Logging deploy ###############################################

	# First backup all files 
		cp -p /etc/syslog.conf /etc/syslog.conf.bkp 
		
		
	#1-		
			tcp_trace=$(svcprop -p defaults/tcp_trace svc:/network/inetd:default)
			echo "tcp_trace $tcp_trace" >> /CIS_vod_sol10/variables.txt
			inetadm -M tcp_trace=true
			svcadm refresh svc:/network/inetd:default
			echo "$(date)             ----- info ----            svc:/network/inetd:default tcp_trace set to true " >> /CIS_vod_sol10/log/cis.log
			
	
	#2	configure ftp exec
			ftp=$(svcprop -p inetd_start/exec svc:/network/ftp:default)
			echo "ftp $ftp" >> /CIS_vod_sol10/variables.txt
			inetadm -m svc:/network/ftp  exec="/usr/sbin/in.ftpd -a -l -d"
			svcadm refresh svc:/network/ftp:default
			echo "$(date)             ----- info ----            svc:/network/ftp:default exec set to $ftp " >> /CIS_vod_sol10/log/cis.log
			
			
	#3 Enable Debug Level Daemon Logging	
			sys_log=$(svcs -Ho state svc:/system/system-log)
			echo "sys_log $sys_log" >> /CIS_vod_sol10/variables.txt ### to make sure it's online 
			grep -v "^#" /etc/syslog.conf | grep /var/log/connlog
			if [ ! "`grep -v '^#' /etc/syslog.conf |  grep /var/log/connlog`" ]; then
				echo -e "daemon.debug\t\t\t/var/log/connlog"  >>/etc/syslog.conf
			fi
			echo -e "debug daemon.debug\t\t\t/var/log/connlog" >> /CIS_vod_sol10/log/cis.log
			touch /var/log/connlog 
			chown root:root /var/log/connlog 
			chmod 600 /var/log/connlog 
			logadm -w connlog -C 13 -a 'pkill -HUP syslogd' /var/log/connlog 
			svcadm refresh svc:/system/system-log
			echo "$(date)             ----- info ----            Enable Debug Level Daemon Logging configured" >> /CIS_vod_sol10/log/cis.log
			
			
	#4 Capture syslog AUTH Messages	
	
			grep -v "^#" /etc/syslog.conf | grep /var/log/authlog
			if [ ! "`grep -v '^#' /etc/syslog.conf |  grep /var/log/authlog`" ]; then
				echo -e "auth.info\t\t\t/var/log/authlog"  >> /etc/syslog.conf
			fi
			echo -e "authlog auth.info\t\t\t/var/log/authlog" >> /CIS_vod_sol10/log/cis.log
			logadm -w authlog -C 13 -a 'pkill -HUP syslogd'  /var/log/authlog
			pkgchk -f -n -p /var/log/authlog
			svcadm refresh svc:/system/system-log
			echo "$(date)             ----- info ----            Capture syslog AUTH Messages configured   " >> /CIS_vod_sol10/log/cis.log
			
			
	#5 Enable Login Records
			
		
			touch /var/adm/loginlog 
			chown root:sys /var/adm/loginlog 
			chmod 600 /var/adm/loginlog 
			logadm -w loginlog -C 13 /var/adm/loginlog
			
			
	#6 Capture All Failed Login Attempts
	
		cp /etc/default/login /etc/default/login.bkp       				# backup 
		awk '/SYSLOG_FAILED_LOGINS=/  { $1 = "SYSLOG_FAILED_LOGINS=0" }; { print }' /etc/default/login > /etc/default/login.new
		mv /etc/default/login.new /etc/default/login
		pkgchk -f -n -p /etc/default/login
	
	
	#7 Enable cron Logging
	
		cp -p /etc/default/cron /etc/default/cron.bkp 						#backup	
		cp -p /var/cron/log /var/cron/log,bkp 								#backup
		awk '/CRONLOG=/ { $1 = "CRONLOG=YES" };  { print }' /etc/default/cron > /etc/default/cron.new
		mv /etc/default/cron.new /etc/default/cron
		pkgchk -f -n -p /etc/default/cron 
		chown root:root /var/cron/log 
		chmod go-rwx /var/cron/log
		
		
	#8 Enable System Accounting
	
		cp -p /var/spool/cron/crontabs/sys /var/spool/cron/crontabs/sys.bkp 
		sar=$(svcs -Ho state svc:/system/sar) 
		echo "sar $sar" >> /CIS_vod_sol10/variables.txt
		svcadm enable -r svc:/system/sar
		echo "0,20,40 * * * * /usr/lib/sa/sa1" >> /var/spool/cron/crontabs/sys 
		echo "45 23 * * * /usr/lib/sa/sa2 -s 0:00 -e 23:59 -i 1200 -A" >> /var/spool/cron/crontabs/sys
		svcadm refresh svc:/system/cron:default
		svcadm restart svc:/system/cron:default
		chown sys:sys /var/adm/sa/* 
		chmod go-wx /var/adm/sa/*
		
		
	#9 Enable Kernel Level Auditing
	
		. ./sub_kernel.sh
		
		
			