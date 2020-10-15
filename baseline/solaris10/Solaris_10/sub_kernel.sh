if [ ! "`grep c2audit:audit_load /etc/system`" ] ; then
 # Turn on auditing 
		echo y | /etc/security/bsmconv 
		cd /etc/security 
		cp -p audit_control audit_control.bkp
		cp -p audit_class audit_class.bkp
		cp -p audit_event audit_event.bkp
		cp -p audit_startup audit_startup.bkp
		cp -p audit_control audit_control.ckp
		cp -p /var/spool/cron/crontabs/root  /var/spool/cron/crontabs/root.bkp 
 # Create a CIS custom class (cc) to audit_class. Apply this class to the 
 # following event types in audit_event: # 
 # fm - file attribute modify

# ps - process start/stop 
# pm - process modify 
# pc - process (meta-class) 
		echo "0x08000000:cc:CIS custom class" >> audit_class 
		awk 'BEGIN { FS = ":"; OFS = ":" } ($4 ~ /fm/) && ! ($2 ~ /MCTL|FCNTL|FLOCK|UTIME/)  { $4 = $4 ",cc" } ($4 ~ /p[cms]/) &&  ! ($2 ~ /FORK|CHDIR|KILL|VTRACE|SETGROUPS|SETPGRP/)  { $4 = $4 ",cc" } { print }' audit_event > audit_event.new
		mv audit_event.new audit_event 
# Set Audit Control parameters 
# Audit Control directory - /var/audit 
# User attributable event flags - login/logout, old administrative (meta class) 
# and CIS Custom class (cc) 
# Non-user attributable (cannot determine user) event flags - login/logout, 
# old administrative (meta class), exec 
# Set minimum space percentage to 20% to force an audit warning. 
cat << END_PARAMS > audit_control 
dir:/var/audit 
flags:lo,ad,cc 
naflags:lo,ad,ex 
minfree:20 
END_PARAMS
# Set up Audit to monitor root for login/logout and old administrative (meta cla ss). Do not audit invalid class (e.g. obsolete) events. 
echo root:lo,ad:no > audit_user 
# Force /usr/sbin to be prepeneded to any naked auditconfig commands 
		awk '/^auditconfig/ { $1 = "/usr/sbin/auditconfig" };  { print }' audit_startup > audit_startup.new 
# Set the audit policy to log exec argv and environment parameters to 
# the audit file 
		echo '/usr/sbin/auditconfig -setpolicy +argv,arge'  >> audit_startup.new 
		mv audit_startup.new audit_startup 
# Verify and set the appropriate permissions/owner/group to the event, control 
# and startup file 
		pkgchk -f -n -p /etc/security/audit_event 
		pkgchk -f -n -p /etc/security/audit_control 
		pkgchk -f -n -p /etc/security/audit_startup 
# Add the command to have cron close the current audit file at the start of 
# each day. 


		echo "0 * * * * /usr/sbin/audit -n" >> /var/spool/cron/crontabs/root 
		svcadm refresh svc:/system/cron:default
		svcadm restart svc:/system/cron:default

fi 
# Set the owner/group/permissions to /var/audit 
chown root:root /var/audit/* 
chmod go-rwx /var/audit/*