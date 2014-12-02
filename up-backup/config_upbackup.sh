#!/bin/bash

# Sua cac thong tin truoc khi thuc thi
HOST='10.30.0.111'
USER='client'
PASSWD='123456a@'
DuongDan='/var/backup/config/'
DuongDanFTP='config_backup'
# Doi ten duong dan khi thuc hien
FILE=`ls -1t $DuongDan | head -1`

/usr/bin/expect - << EOF
   spawn sftp -P 9225 $USER@$HOST:$DuongDanFTP
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $DuongDan$FILE\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
