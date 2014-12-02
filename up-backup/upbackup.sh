#!/bin/bash

HOST='172.16.69.161'
USER='admin'
PASSWD='a'
DuongDan='/root/mysql_folder/'
# Doi ten duong dan khi thuc hien
FILE=`ls -1t $DuongDan | head -1`

/usr/bin/expect - << EOF
   spawn sftp  $USER@$HOST
        expect "password:"
        send "$PASSWD\n"
        expect "sftp>"
        send "put $DuongDan$FILE\n"
        expect "sftp>"
        send "quit\n"
        send_user "done.\n"
        interact
EOF
