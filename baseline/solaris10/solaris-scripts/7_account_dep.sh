#!/bin/sh

# 7 User Accounts and Environment


	#7.1 Disable System Accounts
	
		
		date=`date +%y%m%d` 
		if [ ! -f /etc/shadow.$date.bkp ] 
		then 
			cp -p /etc/shadow /etc/shadow.$date.bkp
			 

		fi 
		awk '/sys/ { $1= "sys:*LK*NP:::::::" } /adm/ { $1= "adm:*LK*NP:::::::" } /lp/ { $1= "lp:*LK*NP:::::::" } /uucp/ { $1= "uucp:*LK*NP:::::::" } /postgres/ { $1= "postgres:*LK*NP:::::::" } { print }' /etc/shadow > /etc/shadow.new 
		mv /etc/shadow.new /etc/shadow 
		chmod 400 /etc/shadow
		
		
	#7.2 Set Password Expiration Parameters on Active Accounts
		
		if [ ! -f /etc/default/passwd.$date.bkp ] 
		then 
			cp -p /etc/default/passwd /etc/default/passwd.$date.bkp
		fi
		logins -ox | awk -F: '($1 == "root" || $8 == "LK" || $8 == "NL") { next } ;  { $cmd = "passwd" } ; ($11 <= 0 || $11 > 91) { $cmd = $cmd " -x 91" }  ($10 < 7) { $cmd = $cmd " -n 7" }  ($12 < 28) { $cmd = $cmd " -w 28" }  ($cmd != "passwd") { print $cmd " " $1 }'  > /etc/CISupd_accounts
		/sbin/sh /etc/CISupd_accounts 
		rm -f /etc/CISupd_accounts 
		
		awk '/PASSLENGTH=/ { $1 = "PASSLENGTH=8" }; /NAMECHECK=/ { $1 = "NAMECHECK=YES" }; /HISTORY=/ { $1 = "HISTORY=10" }; /MINDIFF=/ { $1 = "MINDIFF=3" }; /MINALPHA=/ { $1 = "MINALPHA=2" }; /MINUPPER=/ { $1 = "MINUPPER=1" }; /MINLOWER=/ { $1 = "MINLOWER=1" }; /MINNONALPHA=/ { $1 = "MINNONALPHA=1" }; /MAXREPEATS=/ { $1 = "MAXREPEATS=0" }; /WHITESPACE=/ { $1 = "WHITESPACE=YES" }; /DICTIONDBDIR=/ { $1 = "DICTIONDBDIR=/var/passwd" }; /DICTIONLIST=/  { $1 = "DICTIONLIST=/usr/share/lib/dict/words" }; /^MAXWEEKS/ { $1 = "MAXWEEKS=13" }; /^MINWEEKS/ { $1 = "MINWEEKS=1" } ; /^WARNWEEKS/ { $1 = "WARNWEEKS=4" };  {print}' /etc/default/passwd >> /etc/default/passwd.new 
		
		mv /etc/default/passwd.new /etc/default/passwd 
		pkgchk -f -n -p /etc/default/passwd
		
		
		
	#7.3 Set Strong Password Creation Policies
	
		# Done the previous step
		
		
		
	#7.4 Set Default Group for root Account
		passmgmt -m -g 0 root
		
		
	#7.6
		if [ ! -f /etc/default/login.$date.bkp ] 
		then 
			cp -p /etc/default/login /etc/default/login.$date.bkp
		fi
		#Set Default umask for Users
		awk '/UMASK=/ { $1 = "UMASK=077" } { print }' /etc/default/login >/etc/default/login.new 
		mv /etc/default/login.new /etc/default/login
		