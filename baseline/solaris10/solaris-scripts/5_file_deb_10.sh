# File/Directory Permissions/Access

        # 5.1 Set daemon umask

                cd /etc/default
                cp -p init init.bkp
                awk '/^CMASK=/ { $1 = "CMASK=022" } { print }' init > init.new
                mv init.new init
                pkgchk -f -n -p /etc/default/init


        # 5.2 Restrict Set-UID on User Mounted Devices

                cp -p /etc/rmmount.conf /etc/rmmount.conf.bkp
                if [ ! "`grep -v "^#" /etc/rmmount.conf | grep -- '-o nosuid'`" ]; then
                        fs=`awk '($1 == "ident") && ($2 != "pcfs")  { print $2 }' /etc/rmmount.conf`
                        echo mount \* $fs -o nosuid >> /etc/rmmount.conf
                fi
