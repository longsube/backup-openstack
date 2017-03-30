#!/bin/bash

HOST='10.193.0.105'
USER='mycloudvnn_ftp'
PASSWD='hnCL0UD#@!105'
DuongDan='/var/backup/mysql/'
# Doi ten duong dan khi thuc hien
FILE=`ls -1t $DuongDan | head -1`

/usr/bin/expect - << EOF
set timeout -1
  spawn sftp  $USER@$HOST:mysql_backup
        expect "password:"
        send "$PASSWD\n"
        expect "sftp>"
        send "put $DuongDan$FILE\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF

