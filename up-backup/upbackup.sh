#!/bin/bash

HOST='172.16.69.161'
USER='admin'
PASSWD='a'
# Doi ten duong dan khi thuc hien
FILE=`ls -1t /root/mysql_folder/ | head -1`

/usr/bin/expect - << EOF
   spawn sftp $USER@$HOST
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put /root/mysql_folder/$FILE\r"
        send "exit\r"
        expect "sftp>"
        interact
EOF
