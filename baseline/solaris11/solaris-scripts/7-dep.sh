#!/bin/bash

		#7.1 Set Password Expiration Parameters on Active Accounts
		
			logins -ox | awk -F: '( $1 != "root" && $8 != "LK" && $8 != "NL" &&  ( $10 != "7" || $11 != "91" || $12 != "28" )) { print }' | awk -F: '{print $1}' > /cis-vod-sol11/users.txt
			while IFS= read -r line
do

	if [[ "$line" == "oracle" || "$line" == "grid" || "$line" == "oraaudit" || "$line" == "sec" ||  "$line" == "vp" ||  "$line" == "prepaidivr" ||  "$line" == "ivr" ||  "$line" == "nfs"   ]]; then
		continue
	else
		passwd -x 91 -n 7 -w 28 $line 
	fi
done < /cis-vod-sol11/users.txt

			cp -p /etc/default/passwd /etc/default/passwd.bkp
			cat /etc/default/passwd | grep WARNWEEKS
			if [[ $? == 0 ]]; then
				awk '/MINSPECIAL/ { $1 = "MINSPECIAL=1" }; /MINDIGIT/ { $1 = "MINDIGIT=1" }; /MAXWEEKS/ { $1 = "MAXWEEKS=13" }; /MINWEEKS/ { $1 = "MINWEEKS=1" }; /WARNWEEKS/ { $1 = "WARNWEEKS=1" }; { print }' /etc/default/passwd >> /etc/default/passwd.cis
				mv /etc/default/passwd.cis /etc/default/passwd
			else 
				echo "WARNWEEKS=1" >> /etc/default/passwd
				awk '/MINSPECIAL/ { $1 = "MINSPECIAL=1" }; /MINDIGIT/ { $1 = "MINDIGIT=1" }; /MAXWEEKS/ { $1 = "MAXWEEKS=13" }; /MINWEEKS/ { $1 = "MINWEEKS=1" }; { print }' /etc/default/passwd >> /etc/default/passwd.cis
				mv /etc/default/passwd.cis /etc/default/passwd
			fi
			
		
		#7.2 Set Strong Password Creation Policies
		
			awk '/PASSLENGTH=/ { $1 = "PASSLENGTH=8" }; /NAMECHECK=/ { $1 = "NAMECHECK=YES" }; /HISTORY=/ { $1 = "HISTORY=12" }; /MINDIFF=/ { $1 = "MINDIFF=3" }; /MINALPHA=/ { $1 = "MINALPHA=2" }; /MINUPPER=/ { $1 = "MINUPPER=1" }; /MINLOWER=/ { $1 = "MINLOWER=1" }; /MINNONALPHA=/ { $1 = "MINNONALPHA=1" }; /MAXREPEATS=/ { $1 = "MAXREPEATS=0" }; /WHITESPACE=/ { $1 = "WHITESPACE=YES" }; /DICTIONDBDIR=/ { $1 = "DICTIONDBDIR=/var/passwd" }; /DICTIONLIST=/  { $1 = "DICTIONLIST=/usr/share/lib/dict/words" }; { print }' /etc/default/passwd > /etc/default/passwd.cis
			mv /etc/default/passwd.cis /etc/default/passwd
			
			echo "$(date)             ----- info ----               Set Strong Password Creation Policies     " >> /cis-vod-sol11/log/cis.log
	
	
		#7.3 - Set Default umask for users
				awk '/#UMASK=/ { $1 = "UMASK=027" } { print }' /etc/default/login > /etc/default/login.CIS
				mv /etc/default/login.CIS /etc/default/login

				echo "$(date)             ----- info ----               Set Default umask for users to 027     " >> /cis-vod-sol11/log/cis.log
				
				
				
		#7.5 Set "mesg n" as Default for All Users
		
			cp -p /etc/.login /etc/.login.bkp
			cp -p /etc/profile /etc/profile.bkp
			echo "mesg n" >> /etc/.login
			echo "mesg n" >> /etc/profile
			
		#7.6 Lock Inactive User Accounts
		
		   lock=$(useradd -D | xargs -n 1 | grep inactive | awk -F= '{ print $2 }')
		   echo "lock $lock" >> /cis-vod-sol11/variables.txt
		   useradd -D -f 35
		   
		
