#!/bin/bash


	#5.1-  Set Default Service File Creation Mask
		check=$(svcprop -p umask/umask svc:/system/environment:init)
		echo "umask $check" >> /cis-vod-sol11/variables.txt
		if [ ! $check -eq "022" ]; then
        		svccfg -s svc:/system/environment:init  setprop umask/umask = astring: "022"
		fi

		echo "$(date)             ----- info ----              Set Default Service File Creation Mask to 002  " >> /cis-vod-sol11/log/cis.log



	#5.2- Set Sticky Bit on World Writable Directories (as per customer needs )
		find / \( -fstype nfs -o -fstype cachefs  -o -fstype autofs -o -fstype ctfs  -o -fstype mntfs -o -fstype objfs  -o -fstype proc \) -prune -o -type d  \( -perm -0002 -a ! -perm -1000 \) -print >> /cis-vod-sol11/sticky.txt
		while IFS= read -r line
do
  chmod +t "$line"
done < /cis-vod-sol11/sticky.txt
		



