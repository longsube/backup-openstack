#!/bin/bash

HOST='172.16.69.161'
USER='admin'
PASSWD='a'
DuongDan='/root/mysql_folder/'
# Doi ten duong dan khi thuc hien
FILE=`ls -1t $DuongDan | head -1`

/usr/bin/expect - << EOF
   spawn sftp $USER@$HOST
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $DuongDan$FILE\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
