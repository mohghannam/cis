#!/bin/bash


	#1- disable rstat service 
			rstat=$(svcs -Ho state network/rpc/rstat:default)
			echo "rstat $rstat" >> /CIS_vod_sol10/variables.txt
        	svcadm disable network/rpc/rstat:default
			echo "$(date)             ----- info ----            network/rpc/rstat:default disabled " >> /CIS_vod_sol10/log/cis.log
			
				
			
	#2- disable xfs service 
			xfs=$(svcs -Ho state application/x11/xfs:default)
			echo "xfs $xfs" >> /CIS_vod_sol10/variables.txt
        	svcadm disable application/x11/xfs:default
			echo "$(date)             ----- info ----            application/x11/xfs:default disabled " >> /CIS_vod_sol10/log/cis.log
			

	#3- disable printinfo service 
			printinfo=$(svcs -Ho state application/cde-printinfo:default)
			echo "printinfo $printinfo" >> /CIS_vod_sol10/variables.txt
        	svcadm disable application/cde-printinfo:default
			echo "$(date)             ----- info ----            application/cde-printinfo:default disabled " >> /CIS_vod_sol10/log/cis.log

	#4- disable cde-spc service 
			cde_spc=$(svcs -Ho state network/cde-spc:default)
			echo "cde_spc $cde_spc" >> /CIS_vod_sol10/variables.txt
        	svcadm disable network/cde-spc:default
			echo "$(date)             ----- info ----            network/cde-spc:default disabled " >> /CIS_vod_sol10/log/cis.log
			
	#5- disable dmi service 
			dmi=$(svcs -Ho state application/management/dmi:default)
			echo "dmi $dmi" >> /CIS_vod_sol10/variables.txt
        	svcadm disable application/management/dmi:default
			echo "$(date)             ----- info ----            application/management/dmi:default disabled " >> /CIS_vod_sol10/log/cis.log
			
			
	#6- disable seaport service 
				seaport=$(svcs -Ho state application/management/seaport:default)
				echo "seaport $seaport" >> /CIS_vod_sol10/variables.txt
				svcadm disable application/management/seaport:default
				echo "$(date)             ----- info ----            application/management/seaport:default disabled " >> /CIS_vod_sol10/log/cis.log
				
				
	#7- disable nfs_status service 
				nfs_status=$(svcs -Ho state network/nfs/status:default)
				echo "nfs_status $nfs_status" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/status:default
				echo "$(date)             ----- info ----            network/nfs/status:default disabled " >> /CIS_vod_sol10/log/cis.log
				
				
	#8- disable rusers service 
				rusers=$(svcs -Ho state network/rpc/rusers:default)
				echo "rusers $rusers" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/rpc/rusers:default
				echo "$(date)             ----- info ----            network/rpc/rusers:default disabled " >> /CIS_vod_sol10/log/cis.log
				
				
				
	#9- disable nlockmgr service 
				nlockmgr=$(svcs -Ho state network/nfs/nlockmgr:default)
				echo "nlockmgr $nlockmgr" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/nlockmgr:default
				echo "$(date)             ----- info ----            network/nfs/nlockmgr:default disabled " >> /CIS_vod_sol10/log/cis.log
				
				
				
	#10- disable nfs_client service 
				nfs_client=$(svcs -Ho state network/nfs/client:default)
				echo "nfs_client $nfs_client" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/client:default
				echo "$(date)             ----- info ----            network/nfs/client:default disabled " >> /CIS_vod_sol10/log/cis.log
				
	
	#11- disable nfs_server service 
				nfs_server=$(svcs -Ho state network/nfs/server:default)
				echo "nfs_server $nfs_server" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/server:default
				echo "$(date)             ----- info ----            network/nfs/server:default disabled " >> /CIS_vod_sol10/log/cis.log
	
	
	#12- disable nfs_rquota service 
				nfs_rquota=$(svcs -Ho state network/nfs/rquota:default)
				echo "nfs_rquota $nfs_rquota" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/rquota:default
				echo "$(date)             ----- info ----            network/nfs/rquota:default disabled " >> /CIS_vod_sol10/log/cis.log
	
	
	#13- disable nfs_cbd service 
				nfs_cbd=$(svcs -Ho state network/nfs/cbd:default)
				echo "nfs_cbd $nfs_cbd" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/cbd:default
				echo "$(date)             ----- info ----            network/nfs/cbd:default disabled " >> /CIS_vod_sol10/log/cis.log
	
	
	#14- disable nfs_mapid service 
				nfs_mapid=$(svcs -Ho state network/nfs/mapid:default)
				echo "nfs_mapid $nfs_mapid" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/nfs/mapid:default
				echo "$(date)             ----- info ----            network/nfs/mapid:default disabled " >> /CIS_vod_sol10/log/cis.log
	
	
	#15- disable finger service 
				finger=$(svcs -Ho state network/finger:default)
				echo "finger $finger" >> /CIS_vod_sol10/variables.txt
				svcadm disable network/finger:default
				echo "$(date)             ----- info ----            network/finger:default disabled " >> /CIS_vod_sol10/log/cis.log			
				
				
	#16- disable shell_var service 
			shell_var=$(svcs -Ho state network/shell:default)
			echo "shell_var $shell_var" >> /CIS_vod_sol10/variables.txt
        	svcadm disable network/shell:default
			echo "$(date)             ----- info ----            network/shell:default disabled " >> /CIS_vod_sol10/log/cis.log	


	#17-limit netservices 
	
		echo -e "y\n" | netservices limited


			