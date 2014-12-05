#!/bin/bash
nameSRV=`hostname`
ngay=`eval date +%d%m%Y-%H%M%S`
cd /var/cache/apt/archives/
tenfile="$nameSRV""_""$ngay""_package".tar
tar -cvf /root/backuppackage/$tenfile *deb



HOST='172.16.69.161'
USER='admin'
PASSWD='a'
cd /root/backuppackage/

/usr/bin/expect - << EOF
   spawn sftp $USER@$HOST
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $tenfile \r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
#
# Khai bao duong dan vao day
# find $backup_dir -ctime 7 -type f -delete
