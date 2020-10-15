#!/bin/bash
##################################   CIS-Kernel-Tuning   ##############################

	#3.1 Restrict Core Dumps to Protected Directory
		#chmod 700 /var/cores
		#coreadm -g /var/cores/core_%n_%f_%u_%g_%t_%p  -e log -e global -e global-setid  -d process -d proc-setid
		 coreadm -d global -d global-setid -d process -d proc-setid
		
		
	#3.2 Enable Stack Protection
			cp -p /etc/system.bkp /etc/system
			echo "$(date)             ----- info ----            /etc/system was rolled back  "  >> /cis-vod-sol11/log/cis.log
		
		
	
	#3.3- Enable Strong TCP Sequence Number Generation
			cp -p /etc/default/inetinit.bkp /etc/default/inetinit
			strong_iss=$(cat /cis-vod-sol11/variables.txt | grep strong_iss   | awk '{print $2}')
			ipadm set-prop -p _strong_iss=$strong_iss tcp
		echo "$(date)             ----- info ----                Strong TCP Sequence Number Generation rolled back" >> /cis-vod-sol11/log/cis.log
	

	#3.4 - Disable Source Packet Forwarding
		
		
		forward_src4=$(cat /cis-vod-sol11/variables.txt | grep forward_src4   | awk '{print $2}')
		forward_src6=$(cat /cis-vod-sol11/variables.txt | grep forward_src6   | awk '{print $2}')

		
		ipadm set-prop -p _forward_src_routed=$forward_src6 ipv6
		ipadm set-prop -p _forward_src_routed=$forward_src4 ipv4
		echo "$(date)             ----- info ----		 Source Packet Forwarding rolled back " >> /cis-vod-sol11/log/cis.log
		
		
	#3.5- Disable Directed Broadcast Packet Forwarding
	
		
		forward_directed=$(cat /cis-vod-sol11/variables.txt | grep forward_directed   | awk '{print $2}')
		ipadm set-prop -p _forward_directed_broadcasts=$forward_directed ip
		echo "$(date)             ----- info ----               Directed Broadcast Packet Forwarding rolled back " >> /cis-vod-sol11/log/cis.log
		
		
	#3.6- Disable Response to ICMP Timestamp Requests
		
		respond_to_timestamp=$(cat /cis-vod-sol11/variables.txt | grep "respond_to_timestamp "   | awk '{print $2}')
		ipadm set-prop -p _respond_to_timestamp=$respond_to_timestamp ip
		echo "$(date)             ----- info ----               Response to ICMP Timestamp Requests rolled back " >> /cis-vod-sol11/log/cis.log
		
		
	#3.7- Disable Response to ICMP Broadcast Netmask Requests	
		
		respond_to_timestamp_broadcast=$(cat /cis-vod-sol11/variables.txt | grep respond_to_timestamp_broadcast   | awk '{print $2}')
		ipadm set-prop -p _respond_to_address_mask_broadcast=$respond_to_timestamp_broadcast   ip

		echo "$(date)             ----- info ----               Response to ICMP Broadcast Netmask Requests rolled back " >> /cis-vod-sol11/log/cis.log
		

	#3.8- Disable Response to Broadcast ICMPv4 Echo Request
		
		respond_to_echo_broadcast=$(cat /cis-vod-sol11/variables.txt | grep respond_to_echo_broadcast   | awk '{print $2}')
		ipadm set-prop -p _respond_to_echo_broadcast=$respond_to_echo_broadcast   ip
		echo "$(date)             ----- info ----                Response to Broadcast ICMPv4 Echo Request  rolled back " >> /cis-vod-sol11/log/cis.log
		
	#3.9- Disable Response to Multicast Echo Request
	
		
		
		respond_to_echo_multicast4=$(cat /cis-vod-sol11/variables.txt | grep respond_to_echo_multicast4   | awk '{print $2}')
		respond_to_echo_multicast6=$(cat /cis-vod-sol11/variables.txt | grep respond_to_echo_multicast6   | awk '{print $2}')	
		
		ipadm set-prop -p _respond_to_echo_multicast=$respond_to_echo_multicast4  ipv4
		ipadm set-prop -p _respond_to_echo_multicast=$respond_to_echo_multicast6   ipv6
		echo "$(date)             ----- info ----                Response to Multicast Echo Request rolled back " >> /cis-vod-sol11/log/cis.log	


	#3.10- Ignore ICMP Redirect Messages
		
		
		ignore_redirect4=$(cat /cis-vod-sol11/variables.txt | grep ignore_redirect4   | awk '{print $2}')
		ignore_redirect6=$(cat /cis-vod-sol11/variables.txt | grep ignore_redirect6   | awk '{print $2}')
		
		ipadm set-prop -p _ignore_redirect=$ignore_redirect4   ipv4
		ipadm set-prop -p _ignore_redirect=$ignore_redirect6   ipv6
		
		echo "$(date)             ----- info ----               Ignore ICMP Redirect Messages " >> /cis-vod-sol11/log/cis.log
		
		
	#3.11- Set Strict Multihoming
		
		strict_dst_multihoming4=$(cat /cis-vod-sol11/variables.txt | grep strict_dst_multihoming4   | awk '{print $2}')
		strict_dst_multihoming6=$(cat /cis-vod-sol11/variables.txt | grep strict_dst_multihoming6   | awk '{print $2}')
		
		ipadm set-prop -p _strict_dst_multihoming=$strict_dst_multihoming4   ipv4
		ipadm set-prop -p _strict_dst_multihoming=$strict_dst_multihoming6   ipv6
		
		echo "$(date)             ----- info ----               Set Strict Multihoming " >> /cis-vod-sol11/log/cis.log
		
	#3.12- Disable ICMP Redirect Messages
		#ipadm set-prop -p _send_redirects=0   ipv4
		#ipadm set-prop -p _send_redirects=0   ipv6
		echo "$(date)             ----- info ----               Disable ICMP Redirect Messages " >> /cis-vod-sol11/log/cis.log
		
	#3.13- Disable TCP Reverse IP Source Routing
		
		rev_src_routes=$(cat /cis-vod-sol11/variables.txt | grep rev_src_routes   | awk '{print $2}')
		
		ipadm set-prop -p _rev_src_routes=$rev_src_routes   tcp 

		echo "$(date)             ----- info ----               Disable TCP Reverse IP Source Routing " >> /cis-vod-sol11/log/cis.log
		
		
	#3.14- Set Maximum Number of Half open TCP Connections
		
		conn_req_max_q0=$(cat /cis-vod-sol11/variables.txt | grep conn_req_max_q0   | awk '{print $2}')
		ipadm set-prop -p _conn_req_max_q0=$conn_req_max_q0   tcp 

		echo "$(date)             ----- info ----               Set Maximum Number of Half open TCP Connections " >> /cis-vod-sol11/log/cis.log
		
		
	#3.15- Set Maximum Number of Incoming Connections
		
		conn_req_max_q=$(cat /cis-vod-sol11/variables.txt | grep "^conn_req_max_q "   | awk '{print $2}')
		ipadm set-prop -p _conn_req_max_q=$conn_req_max_q tcp

		echo "$(date)             ----- info ----               Set Maximum Number of Incoming Connections " >> /cis-vod-sol11/log/cis.log
		
		
	#3.16- disable routing internet protocol
	
		ipv4_routing=$(cat /cis-vod-sol11/variables.txt | grep "^ipv4_routing"   | awk '{print $2}')
		if [  "$ipv4_routing" == "disabled" ]; then
			routeadm -d ipv4-forwarding -d ipv4-routing
			routeadm -d ipv6-forwarding -d ipv6-routing
			routeadm -u
		else
			routeadm -e ipv4-forwarding -e ipv4-routing
			routeadm -e ipv6-forwarding -e ipv6-routing
			routeadm -u
		fi
			
