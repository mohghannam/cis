#!/bin/bash
##################################   CIS-Kernel-Tuning   ##############################

	#3.1 Restrict Core Dumps to Protected Directory
		chmod 700 /var/cores
		coreadm -g /var/cores/core_%n_%f_%u_%g_%t_%p  -e log -e global -e global-setid  -d process -d proc-setid
		
		
	#3.2 Enable Stack Protection
		############Save Default configuration ############
			cp -p /etc/system /etc/system.bkp
		###################################################
	if [ ! "`grep noexec_user_stack /etc/system`" ]; then
cat  << EOF >> /etc/system
set noexec_user_stack=1
set noexec_user_stack_log=1
EOF

fi
	
		echo "$(date)             ----- info ----            /etc/system was appended with this to parameters  set_noexec_user_stack=1     set_noexec_user_stack_log=1  "  >> /cis-vod-sol11/log/cis.log
		
		
	
	#3.3- Enable Strong TCP Sequence Number Generation
		################ Save Default Configuration ################
			cp -p /etc/default/inetinit /etc/default/inetinit.bkp
			strong_iss=$(ipadm show-prop -p _strong_iss -co current tcp)
			echo "strong_iss $strong_iss" >> /cis-vod-sol11/variables.txt
		############################################################
		
		awk '/TCP_STRONG_ISS=/ { $1 = "TCP_STRONG_ISS=2" }; { print }' /etc/default/inetinit  > /tmp/inetinit.tmp 
		mv /tmp/inetinit.tmp /etc/default/inetinit 
		chown root:sys /etc/default/inetinit 
		ipadm set-prop -p _strong_iss=2 tcp
		echo "$(date)             ----- info ----                Enble Strong TCP Sequence Number Generation" >> /cis-vod-sol11/log/cis.log
	

	#3.4 - Disable Source Packet Forwarding
		########### Save Default Configuration #############
		forward_src4=$(ipadm show-prop -p _forward_src_routed -co current ipv4)
		forward_src6=$(ipadm show-prop -p _forward_src_routed -co current ipv6)
		echo "forward_src4 $forward_src4" >> /cis-vod-sol11/variables.txt
		echo "forward_src6 $forward_src6" >> /cis-vod-sol11/variables.txt
		####################################################
		ipadm set-prop -p _forward_src_routed=0 ipv6
		ipadm set-prop -p _forward_src_routed=0 ipv4
		echo "$(date)             ----- info ----		Disable Source Packet Forwarding " >> /cis-vod-sol11/log/cis.log
		
		
	#3.5- Disable Directed Broadcast Packet Forwarding
	
		########### Save Default Configuration #############
			forward_directed=$(ipadm show-prop -p _forward_directed_broadcasts -co current ip)
			echo "forward_directed $forward_directed" >> /cis-vod-sol11/variables.txt
		####################################################
		ipadm set-prop -p _forward_directed_broadcasts=0 ip
		echo "$(date)             ----- info ----               Disable Directed Broadcast Packet Forwarding " >> /cis-vod-sol11/log/cis.log
		
		
	#3.6- Disable Response to ICMP Timestamp Requests
		########### Save Default Configuration #############
		respond_to_timestamp=$(ipadm show-prop -p _respond_to_timestamp -co current ip)
		echo "respond_to_timestamp $respond_to_timestamp" >> /cis-vod-sol11/variables.txt
		####################################################
	
		ipadm set-prop -p _respond_to_timestamp=0 ip
		echo "$(date)             ----- info ----               Disable Response to ICMP Timestamp Requests " >> /cis-vod-sol11/log/cis.log
		
		
	#3.7- Disable Response to ICMP Broadcast Netmask Requests	
		########### Save Default Configuration #############
		respond_to_timestamp_broadcast=$(ipadm show-prop -p _respond_to_timestamp_broadcast  -co current ip)
		echo "respond_to_timestamp_broadcast $respond_to_timestamp_broadcast" >> /cis-vod-sol11/variables.txt
		####################################################
		
		ipadm set-prop -p _respond_to_address_mask_broadcast=0   ip

		echo "$(date)             ----- info ----               Disable Response to ICMP Broadcast Netmask Requests " >> /cis-vod-sol11/log/cis.log
		

	#3.8- Disable Response to Broadcast ICMPv4 Echo Request
		########### Save Default Configuration #############
		respond_to_echo_broadcast=$(ipadm show-prop -p _respond_to_echo_broadcast  -co current ip)
		echo "respond_to_echo_broadcast $respond_to_echo_broadcast" >> /cis-vod-sol11/variables.txt
		####################################################
		
		ipadm set-prop -p _respond_to_echo_broadcast=0   ip
		echo "$(date)             ----- info ----               Disable Response to Broadcast ICMPv4 Echo Request " >> /cis-vod-sol11/log/cis.log
		
	#3.9- Disable Response to Multicast Echo Request
	
		########### Save Default Configuration #############
		respond_to_echo_multicast4=$(ipadm show-prop -p _respond_to_echo_multicast -co current ipv4)
		respond_to_echo_multicast6=$(ipadm show-prop -p _respond_to_echo_multicast -co current ipv6)
		echo "respond_to_echo_multicast4 $respond_to_echo_multicast4" >> /cis-vod-sol11/variables.txt
		echo "respond_to_echo_multicast6 $respond_to_echo_multicast6" >> /cis-vod-sol11/variables.txt
		####################################################
		
		
		ipadm set-prop -p _respond_to_echo_multicast=0   ipv4
		ipadm set-prop -p _respond_to_echo_multicast=0   ipv6
		echo "$(date)             ----- info ----               Disable Response to Multicast Echo Request " >> /cis-vod-sol11/log/cis.log	


	#3.10- Ignore ICMP Redirect Messages
		########### Save Default Configuration #############
		ignore_redirect4=$(ipadm show-prop -p _ignore_redirect -co current ipv4)
		ignore_redirect6=$(ipadm show-prop -p _ignore_redirect -co current ipv6)
		echo "ignore_redirect4 $ignore_redirect4" >> /cis-vod-sol11/variables.txt
		echo "ignore_redirect6 $ignore_redirect6" >> /cis-vod-sol11/variables.txt
		####################################################
		
		ipadm set-prop -p _ignore_redirect=1   ipv4
		ipadm set-prop -p _ignore_redirect=1   ipv6
		
		echo "$(date)             ----- info ----               Ignore ICMP Redirect Messages " >> /cis-vod-sol11/log/cis.log
		
		
	#3.11- Set Strict Multihoming
		########### Save Default Configuration #############
		strict_dst_multihoming4=$(ipadm show-prop -p _strict_dst_multihoming -co current ipv4)
		strict_dst_multihoming6=$(ipadm show-prop -p _strict_dst_multihoming -co current ipv6)
		echo "strict_dst_multihoming4 $strict_dst_multihoming4" >> /cis-vod-sol11/variables.txt
		echo "strict_dst_multihoming6 $strict_dst_multihoming6" >> /cis-vod-sol11/variables.txt
		####################################################
		
		ipadm set-prop -p _strict_dst_multihoming=0   ipv4
		ipadm set-prop -p _strict_dst_multihoming=0   ipv6
		
		echo "$(date)             ----- info ----               Set Strict Multihoming " >> /cis-vod-sol11/log/cis.log
		
	#3.12- Disable ICMP Redirect Messages
		ipadm set-prop -p send_redirects=off ipv4
		ipadm set-prop -p send_redirects=off ipv6
		echo "$(date)             ----- info ----               Disable ICMP Redirect Messages " >> /cis-vod-sol11/log/cis.log
		
	#3.13- Disable TCP Reverse IP Source Routing
		################ Save Default Configuration ################
			rev_src_routes=$(ipadm show-prop -p _rev_src_routes -co current tcp)
			echo "rev_src_routes $rev_src_routes" >> /cis-vod-sol11/variables.txt
		############################################################
		
		ipadm set-prop -p _rev_src_routes=0   tcp 

		echo "$(date)             ----- info ----               Disable TCP Reverse IP Source Routing " >> /cis-vod-sol11/log/cis.log
		
		
	#3.14- Set Maximum Number of Half open TCP Connections
		################ Save Default Configuration ################
			conn_req_max_q0=$(ipadm show-prop -p _conn_req_max_q0 -co current tcp)
			echo "conn_req_max_q0 $conn_req_max_q0" >> /cis-vod-sol11/variables.txt
		############################################################

		ipadm set-prop -p _conn_req_max_q0=4096   tcp 

		echo "$(date)             ----- info ----               Set Maximum Number of Half open TCP Connections " >> /cis-vod-sol11/log/cis.log
		
		
	#3.15- Set Maximum Number of Incoming Connections
		################ Save Default Configuration ################
			conn_req_max_q=$(ipadm show-prop -p _conn_req_max_q -co current tcp)
			echo "conn_req_max_q $conn_req_max_q" >> /cis-vod-sol11/variables.txt
		############################################################
		ipadm set-prop -p _conn_req_max_q=1024 tcp

		echo "$(date)             ----- info ----               Set Maximum Number of Incoming Connections " >> /cis-vod-sol11/log/cis.log
		
		
	#3.16- disable routing internet protocol
	
		################ Save Default Configuration ################
		ipv4_routing=$(routeadm -p | egrep "^ipv4-routing " | awk '{printf("%s %s\n", $1, $NF); }' |cut -d '=' -f2)
		ipv4_forwarding=$(routeadm -p | egrep "^ipv4-forwarding " | awk '{printf("%s %s\n", $1, $NF); }' |cut -d '=' -f2)
		ipv6_routing=$(routeadm -p | egrep "^ipv6-routing " | awk '{printf("%s %s\n", $1, $NF); }' |cut -d '=' -f2)
		ipv6_forwarding=$(routeadm -p | egrep "^ipv6-forwarding " | awk '{printf("%s %s\n", $1, $NF); }' |cut -d '=' -f2)
	
		ipv4_routing_p=$(routeadm -p | egrep "^ipv4-routing " | awk '{printf("%s %s\n", $1, $2); }' |cut -d '=' -f2)
		ipv4_forwarding_p=$(routeadm -p | egrep "^ipv4-forwarding " | awk '{printf("%s %s\n", $1, $2); }' |cut -d '=' -f2)
		ipv6_routing_p=$(routeadm -p | egrep "^ipv6-routing " | awk '{printf("%s %s\n", $1, $2); }' |cut -d '=' -f2)
		ipv6_forwarding_p=$(routeadm -p | egrep "^ipv6-forwarding " | awk '{printf("%s %s\n", $1, $2); }' |cut -d '=' -f2)
		
		echo "ipv4_routing $ipv4_routing" >> /cis-vod-sol11/variables.txt
		echo "ipv4_forwarding $ipv4_forwarding" >> /cis-vod-sol11/variables.txt
		echo "ipv6_routing $ipv6_routing" >> /cis-vod-sol11/variables.txt
		echo "ipv6_forwarding $ipv6_forwarding" >> /cis-vod-sol11/variables.txt
		
		echo "ipv4_routing-p $ipv4_routing_p" >> /cis-vod-sol11/variables.txt
		echo "ipv4_forwarding-p $ipv4_forwarding_p" >> /cis-vod-sol11/variables.txt
		echo "ipv6_routing-p $ipv6_routing_p" >> /cis-vod-sol11/variables.txt
		echo "ipv6_forwarding-p $ipv6_forwarding_p" >> /cis-vod-sol11/variables.txt
		############################################################
		

		routeadm -d ipv4-forwarding -d ipv4-routing
		routeadm -d ipv6-forwarding -d ipv6-routing
		routeadm -u

		echo "$(date)             ----- info ----               disable routing internet protocol " >> /cis-vod-sol11/log/cis.log
