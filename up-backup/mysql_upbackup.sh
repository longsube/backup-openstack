#!/bin/bash


# Sua thong tin truoc khi thuc thi
HOST='X.X.X.X'
USER='client'
PASSWD='123456a@'
DuongDan='/var/backup/mysql/'
# Doi ten duong dan khi thuc hien
FILE=`ls -1t $DuongDan | head -1`

/usr/bin/expect - << EOF
   spawn sftp -P 9225 $USER@$HOST:mysql_backup
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $DuongDan$FILE\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
