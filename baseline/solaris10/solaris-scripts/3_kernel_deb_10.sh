#!/bin/bash
##################################   CIS-Kernel-Tuning   ##############################
	
	#1- Network parameters
		
		a=$(ndd -get /dev/ip ip_forward_src_routed)                    ; echo a=$a >> /CIS_vod_sol10/kernel_vars.txt 
		b=$(ndd -get /dev/ip ip6_forward_src_routed)                   ; echo b=$b >> /CIS_vod_sol10/kernel_vars.txt
		c=$(ndd -get /dev/tcp tcp_rev_src_routes)                      ; echo c=$c >> /CIS_vod_sol10/kernel_vars.txt
		e=$(ndd -get /dev/ip ip_forward_directed_broadcasts)           ; echo e=$e >> /CIS_vod_sol10/kernel_vars.txt
		f=$(ndd -get /dev/tcp tcp_conn_req_max_q0)                     ; echo f=$f >> /CIS_vod_sol10/kernel_vars.txt
		g=$(ndd -get /dev/tcp tcp_conn_req_max_q)                      ; echo g=$g >> /CIS_vod_sol10/kernel_vars.txt
		h=$(ndd -get /dev/ip ip_respond_to_timestamp)                  ; echo h=$h >> /CIS_vod_sol10/kernel_vars.txt
		i=$(ndd -get /dev/ip ip_respond_to_timestamp_broadcast)        ; echo i=$i >> /CIS_vod_sol10/kernel_vars.txt
		j=$(ndd -get /dev/ip ip_respond_to_address_mask_broadcast)     ; echo j=$j >> /CIS_vod_sol10/kernel_vars.txt
		k=$(ndd -get /dev/ip ip_respond_to_echo_multicast)             ; echo k=$k >> /CIS_vod_sol10/kernel_vars.txt
		l=$(ndd -get /dev/ip ip6_respond_to_echo_multicast)            ; echo l=$l >> /CIS_vod_sol10/kernel_vars.txt
		m=$(ndd -get /dev/ip ip_respond_to_echo_broadcast)             ; echo m=$m >> /CIS_vod_sol10/kernel_vars.txt
		n=$(ndd -get /dev/arp arp_cleanup_interval)                    ; echo n=$n >> /CIS_vod_sol10/kernel_vars.txt
		o=$(ndd -get /dev/ip ip_ire_arp_interval)                      ; echo o=$o >> /CIS_vod_sol10/kernel_vars.txt
		p=$(ndd -get /dev/ip ip_ignore_redirect)                       ; echo p=$p >> /CIS_vod_sol10/kernel_vars.txt
		q=$(ndd -get /dev/ip ip6_ignore_redirect)                      ; echo q=$q >> /CIS_vod_sol10/kernel_vars.txt
		r=$(ndd -get /dev/tcp tcp_extra_priv_ports)                    ; echo r=$r >> /CIS_vod_sol10/kernel_vars.txt
		s=$(ndd -get /dev/ip ip_strict_dst_multihoming)                ; echo s=$s >> /CIS_vod_sol10/kernel_vars.txt
		t=$(ndd -get /dev/ip ip6_strict_dst_multihoming)               ; echo t=$t >> /CIS_vod_sol10/kernel_vars.txt
		u=$(ndd -get /dev/ip ip_send_redirects)                        ; echo u=$u >> /CIS_vod_sol10/kernel_vars.txt
		v=$(ndd -get /dev/ip ip6_send_redirects)                       ; echo v=$v >> /CIS_vod_sol10/kernel_vars.txt


cat > /CIS_vod_sol10/cis_netconfig.sh << END 
#!/sbin/sh 
ndd -set /dev/ip ip_forward_src_routed 0 
ndd -set /dev/ip ip6_forward_src_routed 0 
ndd -set /dev/tcp tcp_rev_src_routes 0 
ndd -set /dev/ip ip_forward_directed_broadcasts 0 
ndd -set /dev/tcp tcp_conn_req_max_q0 4096
ndd -set /dev/tcp tcp_conn_req_max_q 1024 
ndd -set /dev/ip ip_respond_to_timestamp 0 
ndd -set /dev/ip ip_respond_to_timestamp_broadcast 0 
ndd -set /dev/ip ip_respond_to_address_mask_broadcast 0 
ndd -set /dev/ip ip_respond_to_echo_multicast 0 
ndd -set /dev/ip ip6_respond_to_echo_multicast 0 
ndd -set /dev/ip ip_respond_to_echo_broadcast 0 
ndd -set /dev/arp arp_cleanup_interval 60000 
ndd -set /dev/ip ip_ire_arp_interval 60000 
ndd -set /dev/ip ip_ignore_redirect 1 
ndd -set /dev/ip ip6_ignore_redirect 1 
ndd -set /dev/tcp tcp_extra_priv_ports_add 6112 
ndd -set /dev/ip ip_strict_dst_multihoming 1 
ndd -set /dev/ip ip6_strict_dst_multihoming 1 
ndd -set /dev/ip ip_send_redirects 0 
ndd -set /dev/ip ip6_send_redirects 0 
END

	chmod 750 /CIS_vod_sol10/cis_netconfig.sh 
	/CIS_vod_sol10/cis_netconfig.sh 

	
	
	#2- coredump
		coreadm >> /CIS_vod_sol10/coreadm.out
		mkdir -p /var/cores
		chown root:root /var/cores
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
	
		echo "$(date)             ----- info ----            /etc/system was appended with this to parameters  set_noexec_user_stack=1     set_noexec_user_stack_log=1  "  >> /CIS_vod_sol10/log/cis.log


		
		
	#3.3- Enable Strong TCP Sequence Number Generation
		################ Save Default Configuration ################
			cp -p /etc/default/inetinit /etc/default/inetinit.bkp
			strong_iss=$(ndd -get /dev/tcp tcp_strong_iss)
			echo "strong_iss $strong_iss" >> /CIS_vod_sol10/variables.txt
		############################################################
		
		awk '/TCP_STRONG_ISS=/ { $1 = "TCP_STRONG_ISS=2" }; { print }' /etc/default/inetinit  > /tmp/inetinit.tmp 
		mv /tmp/inetinit.tmp /etc/default/inetinit 
		chown root:sys /etc/default/inetinit 
		ndd -set /dev/tcp tcp_strong_iss 2
		echo "$(date)             ----- info ----                Enble Strong TCP Sequence Number Generation" >> /CIS_vod_sol10/log/cis.log
		
		
		
	#4- disable routing Internet protocol
	
		routeadm -p | egrep "^ipv[46]-routing |^ipv[46]-forwarding" | awk '{ printf("%s %s\n", $1, $NF); }' >> /CIS_vod_sol10/routeadm.out
		routeadm -d ipv4-forwarding -d ipv6-forwarding
		routeadm -d ipv4-routing -d ipv6-routing
		routeadm -u
		
		echo "$(date)             ----- info ----               disable routing internet protocol " >> /CIS_vod_sol10/log/cis.log
	
