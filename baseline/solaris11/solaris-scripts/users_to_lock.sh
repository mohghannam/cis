#!/bin/bash

for user in aiuser dhcpserv dladm ftp gdm netadm netcfg noaccess nobody nobody4 openldap pkg5srv svctag unknown webservd xvm;
do
        stat=`passwd -s ${user} | awk '{ print $2 }'`
        if [ "${stat}" != "LK" ]; then
                echo "Account ${user} is not locked."
        fi
done
