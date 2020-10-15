#!/bin/bash

for user in adm bin daemon lp mysql nuucp postgres smmsp sys upnp uucp zfssnap;
		do
		stat=`passwd -s ${user} | awk '{ print $2 }'`
			if [ "${stat}" != "NL" ]; then 
				echo "Account ${user} is not non-login." 
			fi 
		done
