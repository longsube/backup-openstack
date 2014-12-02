#!/bin/bash

HOST='10.30.0.111'
USER='ftp_client'
PASSWD='Vdc1T@!d3m0'
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
