#!/bin/bash

mkdir -p /CIS_vod_sol10/log



	#1- disable cde-ttdbserver service 
			cde=$(svcs -Ho state svc:/network/rpc/cde-ttdbserver:tcp)
			echo "cde $cde" >> /CIS_vod_sol10/variables.txt
        	svcadm disable svc:/network/rpc/cde-ttdbserver:tcp
			echo "$(date)             ----- info ----            svc:/network/rpc/cde-ttdbserver:tcp disabled " >> /CIS_vod_sol10/log/cis.log
	   
	#2- disable cde-calendar-manager services
	
			cde_M=$(svcs -Ho state svc:/network/rpc/cde-calendar-manager:default)
			echo "cde_M $cde_M" >> /CIS_vod_sol10/variables.txt
        	svcadm disable svc:/network/rpc/cde-calendar-manager:default
			echo "$(date)             ----- info ----            svc:/network/rpc/cde-calendar-manager:default disabled " >> /CIS_vod_sol10/log/cis.log
		
	#3- disable graphical-login services
	
			graphical=$(svcs -Ho state svc:/application/graphical-login/cde-login)
			echo "graphical $graphical" >> /CIS_vod_sol10/variables.txt
        	svcadm disable svc:/application/graphical-login/cde-login
			echo "$(date)             ----- info ----            svc:/application/graphical-login/cde-login disabled " >> /CIS_vod_sol10/log/cis.log
		
	#4- disable gdm service 
			gdm=$(svcs -Ho state svc:/application/gdm2-login)
			echo "gdm $gdm" >> /CIS_vod_sol10/variables.txt
			svcadm disable svc:/application/gdm2-login
			echo "$(date)             ----- info ----            svc:/application/gdm2-login disabled" >> /CIS_vod_sol10/log/cis.log
			
	
	#5- disable webconsole service 
			webconsole=$(svcs -Ho state svc:/system/webconsole:console)
			echo "webconsole $webconsole" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/system/webconsole:console
			echo "$(date)             ----- info ----            svc:/system/webconsole:console disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#6- disable wbem service 
			wbem=$(svcs -Ho state svc:/application/management/wbem)
			echo "wbem $wbem" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/application/management/wbem
			echo "$(date)             ----- info ----            svc:/application/management/wbem disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#7- disable rfc1179 service 
			rfc1179=$(svcs -Ho state svc:/application/print/rfc1179)
			echo "rfc1179 $rfc1179" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/application/print/rfc1179
			echo "$(date)             ----- info ----            svc:/application/print/rfc1179 disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#8- disable rfc1179 service 
			rfc1179=$(svcs -Ho state svc:/application/print/rfc1179)
			echo "rfc1179 $rfc1179" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/application/print/rfc1179
			echo "$(date)             ----- info ----            svc:/application/print/rfc1179 disabled " >> /CIS_vod_sol10/log/cis.log
			
	#9- disable keyserv service 
			keyserv=$(svcs -Ho state svc:/network/rpc/keyserv)
			echo "keyserv $keyserv" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/rpc/keyserv
			echo "$(date)             ----- info ----            svc:/network/rpc/keyserv disabled " >> /CIS_vod_sol10/log/cis.log
			
	
	#9- disable keyserv service 
			keyserv=$(svcs -Ho state svc:/network/rpc/keyserv)
			echo "keyserv $keyserv" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/rpc/keyserv
			echo "$(date)             ----- info ----            svc:/network/rpc/keyserv disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#10- disable nis service 
			nis=$(svcs -Ho state svc:/network/nis/server)
			passwd=$(svcs -Ho state svc:/network/nis/passwd)
			update=$(svcs -Ho state svc:/network/nis/update)
			xfr=$(svcs -Ho state svc:/network/nis/xfr)
			client=$(svcs -Ho state svc:/network/nis/client)
			
			
			echo "nis $nis" >> /CIS_vod_sol10/variables.txt
			echo "passwd $passwd" >> /CIS_vod_sol10/variables.txt
			echo "update $update" >> /CIS_vod_sol10/variables.txt
			echo "xfr $xfr" >> /CIS_vod_sol10/variables.txt
			echo "client $client" >> /CIS_vod_sol10/variables.txt
			
			svcadm disable  svc:/network/nis/server
			svcadm disable  svc:/network/nis/passwd
			svcadm disable  svc:/network/nis/update
			svcadm disable  svc:/network/nis/xfr
			svcadm disable  svc:/network/nis/client
			
			echo "$(date)             ----- info ----            svc:/network/nis/server disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/nis/passwd disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/nis/update disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/nis/xfr disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/nis/client			disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#11- disable nisplus service 
			nisplus=$(svcs -Ho state svc:/network/rpc/nisplus)
			echo "nisplus $nisplus" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/rpc/nisplus
			echo "$(date)             ----- info ----            svc:/network/rpc/nisplus disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#12- disable ldapc service 
			ldapc=$(svcs -Ho state svc:/network/ldap/client)
			echo "ldapc $ldapc" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/ldap/client
			echo "$(date)             ----- info ----            svc:/network/ldap/client disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#13- disable ktkt_warn service 
			ktkt_warn=$(svcs -Ho state svc:/network/security/ktkt_warn)
			echo "ktkt_warn $ktkt_warn" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/security/ktkt_warn
			echo "$(date)             ----- info ----            svc:/network/security/ktkt_warn disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#14- disable gss service 
			gss=$(svcs -Ho state svc:/network/rpc/gss)
			echo "gss $gss" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/rpc/gss
			echo "$(date)             ----- info ----            svc:/network/rpc/gss disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#14- disable volfs service 
			volfs=$(svcs -Ho state svc:/system/filesystem/volfs)
			echo "volfs $volfs" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/system/filesystem/volfs
			echo "$(date)             ----- info ----            svc:/system/filesystem/volfs disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#15- disable smserver service 
			smserver=$(svcs -Ho state svc:/network/rpc/smserver)
			echo "smserver $smserver" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/rpc/smserver
			echo "$(date)             ----- info ----            svc:/network/rpc/smserver disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#16- disable samba service 
			samba=$(svcs -Ho state svc:/network/samba)
			echo "samba $samba" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/samba
			echo "$(date)             ----- info ----            svc:/network/samba disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#13- disable autofs service 
			autofs=$(svcs -Ho state svc:/system/filesystem/autofs)
			echo "autofs $autofs" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/system/filesystem/autofs
			echo "$(date)             ----- info ----            svc:/system/filesystem/autofs disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#13- disable apache2 service 
			apache2=$(svcs -Ho state svc:/network/http:apache2)
			echo "apache2 $apache2" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/http:apache2
			echo "$(date)             ----- info ----            svc:/network/http:apache2 disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#13- disable Solaris volume manager service 
			metainit=$(svcs -Ho state svc:/system/metainit)
			mdmonitor=$(svcs -Ho state svc:/system/mdmonitor)
			mpxio=$(svcs -Ho state mpxio-upgrade)
			
			echo "metainit $metainit" >> /CIS_vod_sol10/variables.txt
			echo "mdmonitor $mdmonitor" >> /CIS_vod_sol10/variables.txt
			echo "mpxio $mpxio" >> /CIS_vod_sol10/variables.txt
			
			svcadm disable  svc:/system/metainit
			svcadm disable  svc:/system/mdmonitor
			svcadm disable  mpxio-upgrade
			
			echo "$(date)             ----- info ----            svc:/system/metainit disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/system/mdmonitor disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            mpxio-upgrade disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#13- disable Solaris volume manager  GUI service 
			mdcomm=$(svcs -Ho state svc:/network/rpc/mdcomm)
			meta=$(svcs -Ho state svc:/network/rpc/meta)
			metamed=$(svcs -Ho state svc:/network/rpc/metamed:default)
			metamh=$(svcs -Ho state svc:/network/rpc/metamh:default)
			
			echo "mdcomm $mdcomm" >> /CIS_vod_sol10/variables.txt
			echo "meta $meta" >> /CIS_vod_sol10/variables.txt
			echo "metamed $metamed" >> /CIS_vod_sol10/variables.txt
			echo "metamh $metamh" >> /CIS_vod_sol10/variables.txt
			
			svcadm disable  svc:/network/rpc/mdcomm
			svcadm disable  svc:/network/rpc/meta
			svcadm disable  svc:/network/rpc/metamed
			svcadm disable  svc:/network/rpc/metamh
			
			echo "$(date)             ----- info ----            svc:/network/rpc/mdcomm disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/rpc/meta disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/rpc/metamed disabled " >> /CIS_vod_sol10/log/cis.log
			echo "$(date)             ----- info ----            svc:/network/rpc/metamh disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#13- disable bind service 
			bind=$(svcs -Ho state svc:/network/rpc/bind)
			echo "bind $bind" >> /CIS_vod_sol10/variables.txt
			svcadm disable  svc:/network/rpc/bind
			echo "$(date)             ----- info ----            svc:/network/rpc/bind disabled " >> /CIS_vod_sol10/log/cis.log
			





	#11- configure TCP_Wrapper " Must be set manual by the customer needs "
	#	check if it s enabled or not
	#		#inetadm -p | grep tcp_wrappers
	#		#inetadm -M tcp_wrappers
	#	check the files	
	#		/etc/hosts.allow
	#		/etc/hosts.deny
	#	synatx :
	#		ALL:ALL
	#		ALL : the daemons
	#		ALL the client
	#		

