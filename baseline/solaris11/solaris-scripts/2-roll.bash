#/bin/bash
# This script is used to rollback all services mentioned in he CIS document to it is normal state


		#1- rpc/bind service 
			bind=$(cat /cis-vod-sol11/variables.txt | grep bind     | awk '{print $2}')
			if [  "$bind" == "online" ]; then
				svcadm enable rpc/bind
				svcadm clear rpc/bind  2> /dev/null
			else 
				svcadm disable  rpc/bind
			fi
			
			
		#2- keyserv service
			keyserv=$(cat /cis-vod-sol11/variables.txt | grep keyserv  | awk '{print $2}')
			if [  "$keyserv" == "online" ]; then
				svcadm enable svc:/network/rpc/keyserv:default
				svcadm clear svc:/network/rpc/keyserv:default  2> /dev/null
			else 
				svcadm disable  svc:/network/rpc/keyserv:default
			fi
			
			
		#3- nisdom service
			nisdom=$(cat /cis-vod-sol11/variables.txt | grep nisdom   | awk '{print $2}')
			if [  "$nisdom" == "online" ]; then
				svcadm enable svc:/network/nis/domain:default
				svcadm clear svc:/network/nis/domain:default  2> /dev/null
			else 
				svcadm disable  svc:/network/nis/domain:default
			fi
			
			
		#4- niscli service
			niscli=$(cat /cis-vod-sol11/variables.txt | grep niscli   | awk '{print $2}')
			if [  "$niscli" == "online" ]; then
				svcadm enable svc:/network/nis/client:default
				svcadm clear svc:/network/nis/client:default  2> /dev/null
			else 
				svcadm disable  svc:/network/nis/client:default
			fi
			
			
		#5- ktkt service
			ktkt=$(cat /cis-vod-sol11/variables.txt | grep ktkt     | awk '{print $2}')
			if [  "$ktkt" == "online" ]; then
				svcadm enable svc:/network/security/ktkt_warn:default
				svcadm clear svc:/network/security/ktkt_warn:default  2> /dev/null
			else 
				svcadm disable  svc:/network/security/ktkt_warn:default
			fi
			
			
		#6- gss service
			gss=$(cat /cis-vod-sol11/variables.txt | grep gss      | awk '{print $2}')
			if [  "$gss" == "online" ]; then
				svcadm enable svc:/network/rpc/gss:default
				svcadm clear svc:/network/rpc/gss:default  2> /dev/null
			else 
				svcadm disable  svc:/network/rpc/gss:default
			fi
			
			
		#7- rmvolmgr service
			rmvolmgr=$(cat /cis-vod-sol11/variables.txt | grep rmvolmgr | awk '{print $2}')
			if [  "$rmvolmgr" == "online" ]; then
				svcadm enable svc:/system/filesystem/rmvolmgr:default
				svcadm clear svc:/system/filesystem/rmvolmgr:default  2> /dev/null
			else 
				svcadm disable  svc:/system/filesystem/rmvolmgr:default
			fi
			
			
		#8- smserver service	
			smserver=$(cat /cis-vod-sol11/variables.txt | grep smserver | awk '{print $2}')
			if [  "$smserver" == "online" ]; then
				svcadm enable svc:/network/rpc/smserver:default
				svcadm clear svc:/network/rpc/smserver:default  2> /dev/null
			else 
				svcadm disable  svc:/network/rpc/smserver:default
			fi
			
		
		#9- autofs service	
			autofs=$(cat /cis-vod-sol11/variables.txt | grep autofs   | awk '{print $2}')
			if [  "$autofs" == "online" ]; then
				svcadm enable svc:/system/filesystem/autofs:default
				svcadm clear svc:/system/filesystem/autofs:default  2> /dev/null
			else 
				svcadm disable  svc:/system/filesystem/autofs:default
			fi
			
			
		#10- apache22 service	
			apache22=$(cat /cis-vod-sol11/variables.txt | grep apache22 | awk '{print $2}')
			if [  "$apache22" == "online" ]; then
				svcadm enable svc:/network/http:apache22
				svcadm clear svc:/network/http:apache22  2> /dev/null
			else 
				svcadm disable  svc:/network/http:apache22
			fi
			
		
		#11- telnet service	
			telnet=$(cat /cis-vod-sol11/variables.txt | grep telnet   | awk '{print $2}')
			if [  "$telnet" == "online" ]; then
				svcadm enable network/telnet
				svcadm clear network/telnet  2> /dev/null
			else 
				svcadm disable  network/telnet
				
			fi
		
		
		
		#12- sendmail service 
			smtp=$(cat /cis-vod-sol11/variables.txt | grep smtp     | awk '{print $2}')
			if [  "$smtp" == "true" ]; then
				svccfg -s svc:/network/smtp:sendmail setprop  config/local_only=true
				svcadm restart svc:/network/smtp:sendmail
				svcadm refresh svc:/network/smtp:sendmail
			elif  [  "$smtp" == "false" ]; then
				svccfg -s svc:/network/smtp:sendmail setprop  config/local_only=false 
			    svcadm restart svc:/network/smtp:sendmail
		        svcadm refresh svc:/network/smtp:sendmail
			fi
		
		
	#	TCP_Wrapper
			tcp_wrab=$(cat /cis-vod-sol11/variables.txt | grep  TCP_Wrapper    | awk '{print $3}')
			if [  "$tcp_wrab" == "TRUE" ]; then
				inetadm -M tcp_wrappers=Flase
				mv /etc/hosts.deny   /etc/hosts.deny.cis
				mv /etc/hosts.allow /etc/hosts.allow.cis
			else	
				inetadm -M tcp_wrappers=TRUE
				mv /etc/hosts.deny.cis  /etc/hosts.deny
				mv /etc/hosts.allow.cis /etc/hosts.allow
		
		
		


