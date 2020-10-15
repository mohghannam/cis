#!/bin/bash

beadm create PRE_CIS
mkdir -p /cis-vod-sol11/log


#####   must be large server | check for large server group package to proceed

pkg list -Hs \*group\* | awk '{ print $1 }' | grep large
check=$(echo $?)
if [ ! $check -eq 0 ]; then
	exit 1
else
	#1- check if the graphical service login is enabled
			svcs -a | grep graphical
			check=$(echo $?)
			if [ ! $check -eq 0 ]; then
				echo "$(date)             ----- info ----            this server is text " >> /cis-vod-sol11/log/cis.log
			else
				grapical=$(svcs svc:/application/graphical-login/gdm:default | grep svc:/application/graphical-login/gdm:default | awk '{print $1}')
				echo "graphical $graphical" >> /cis-vod-sol11/variables.txt
				svcadm disable svc:/application/graphical-login/gdm:default
				echo "$(date)             ----- info ----            service svc:/application/graphical-login/gdm:default disabled " >> /cis-vod-sol11/log/cis.log
			fi


	#2- set sendmail service to local_only
			smtp=$(svccfg -s svc:/network/smtp:sendmail listprop config/local_only | awk '{print $3}')
			echo "smtp $smtp" >> /cis-vod-sol11/variables.txt
        	svccfg -s svc:/network/smtp:sendmail setprop  config/local_only=true
        	svcadm restart svc:/network/smtp:sendmail
        	svcadm refresh svc:/network/smtp:sendmail
			echo "$(date)             ----- info ----            service svc:/network/smtp:sendmail set to local_only " >> /cis-vod-sol11/log/cis.log


	#3- disable keyserv service 
			keyserv=$(svcs svc:/network/rpc/keyserv:default | grep svc:/network/rpc/keyserv:default | awk '{print $1}')
			echo "keyserv $keyserv" >> /cis-vod-sol11/variables.txt
        	svcadm disable svc:/network/rpc/keyserv:default
			echo "$(date)             ----- info ----            service svc:/network/rpc/keyserv:default disabled " >> /cis-vod-sol11/log/cis.log
	   
	#4- disable nis services
			nisdom=$(svcs svc:/network/nis/domain:default |grep svc:/network/nis/domain:default | awk '{print $1}')
			niscli=$(svcs svc:/network/nis/client:default |grep svc:/network/nis/client:default | awk '{print $1}')
			echo "nisdom $nisdom" >> /cis-vod-sol11/variables.txt
			echo "niscli $niscli" >> /cis-vod-sol11/variables.txt
			svcadm disable svc:/network/nis/domain:default
			svcadm disable svc:/network/nis/client:default
			echo "$(date)             ----- info ----            service svc:/network/nis/domain:default disabled" >> /cis-vod-sol11/log/cis.log
			echo "$(date)             ----- info ----            service svc:/network/nis/client:default disabled" >> /cis-vod-sol11/log/cis.log
		
	#5- disble ktkt service 
			ktkt=$(svcs svc:/network/security/ktkt_warn:default |grep svc:/network/security/ktkt_warn:default | awk '{print $1}')
			echo "ktkt $ktkt" >> /cis-vod-sol11/variables.txt
        	svcadm disable svc:/network/security/ktkt_warn:default
			echo "$(date)             ----- info ----            service svc:/network/security/ktkt_warn:default disabled " >> /cis-vod-sol11/log/cis.log
		
	#6- disable gss service 
			gss=$(svcs svc:/network/rpc/gss:default |grep svc:/network/rpc/gss:default | awk '{print $1}')
			echo "gss $gss" >> /cis-vod-sol11/variables.txt
			svcadm disable svc:/network/rpc/gss:default
			echo "$(date)             ----- info ----            service svc:/network/rpc/gss:default disabled " >> /cis-vod-sol11/log/cis.log
		
	#7-disable rmvolmgr 
			rmvolmgr=$(svcs svc:/system/filesystem/rmvolmgr:default |grep svc:/system/filesystem/rmvolmgr:default | awk '{print $1}')
			smserver=$(svcs svc:/network/rpc/smserver:default |grep svc:/network/rpc/smserver:default | awk '{print $1}')
			echo "rmvolmgr $rmvolmgr" >> /cis-vod-sol11/variables.txt
			echo "smserver $smserver" >> /cis-vod-sol11/variables.txt
			svcadm disable svc:/system/filesystem/rmvolmgr:default
			svcadm disable svc:/network/rpc/smserver:default
			inetadm -d svc:/network/rpc/smserver:default
			echo "$(date)             ----- info ----            service svc:/system/filesystem/rmvolmgr:default disabled" >> /cis-vod-sol11/log/cis.log
			echo "$(date)             ----- info ----            service svc:/network/rpc/smserver:default disabled " >> /cis-vod-sol11/log/cis.log
		
	#8- disable autofs "not recommended by linux plus" 
			autofs=$(svcs svc:/system/filesystem/autofs:default |grep svc:/system/filesystem/autofs:default | awk '{print $1}')
			echo "autofs $autofs" >> /cis-vod-sol11/variables.txt
			svcadm disable svc:/system/filesystem/autofs:default
			#echo "$(date)             ----- info ----            service svc:/system/filesystem/autofs:default disabled " >> /cis-vod-sol11/log/cis.log
		
	#9- disable apache service "not recommended by linux plus"
			apache22=$(svcs svc:/network/http:apache22 |grep svc:/network/http:apache22 | awk '{print $1}')
			echo "apache22 $apache22" >> /cis-vod-sol11/variables.txt
			svcadm disable svc:/network/http:apache22
			echo "$(date)             ----- info ----            service svc:/network/http:apache22 disabled " >> /cis-vod-sol11/log/cis.log
		
	#10- disable rpc/bind "not recommended by linux plus"
			bind=$(svcs svc:/network/rpc/bind:default |grep svc:/network/rpc/bind:default | awk '{print $1}')
			echo "bind $bind" >> /cis-vod-sol11/variables.txt
			svcadm disable svc:/network/rpc/bind:default
			echo "$(date)             ----- info ----            service svc:/network/rpc/bind:default disabled "  >> /cis-vod-sol11/log/cis.log
		

	#	11- configure TCP_Wrapper " Must be set manual by the customer needs "
	#		check if it s enabled or not
			for svc in `inetadm | awk '/svc:\// { print $NF }'`; do
				val=`inetadm -l ${svc} | grep -c tcp_wrappers=TRUE`
				if [ ${val} -eq 1 ]; then 
					echo "TCP Wrappers enabled for ${svc}" 
				fi 
			done
			tcp_wrab=$(inetadm -p | grep tcp_wrappers )
			echo "TCP_Wrapper $tcp_wrab" >> /cis-vod-sol11/variables.txt
	
			inetadm -M tcp_wrappers=TRUE
	#	check the files	
	#		/etc/hosts.allow
	#		/etc/hosts.deny
	#	synatx :
			echo "ALL: ALL" >> /etc/hosts.allow
			echo "ALL: ALL" >/etc/hosts.deny 
			svccfg -s rpc/bind setprop config/enable_tcpwrappers=true
			svcadm refresh rpc/bind
	#		ALL : the daemons
	#		ALL the client
	#		


	#12- disable telnet service
		telnet=$(svcs network/telnet |grep network/telnet | awk '{print $1}')
		echo "telnet $telnet" >> /cis-vod-sol11/variables.txt
		svcadm disable network/telnet
		echo "$(date)             ----- info ----            service network/telnet  disabled "  >> /cis-vod-sol11/log/cis.log

fi
