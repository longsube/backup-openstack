#!/bin/bash

HOST='x.x.x.x'
USER='yyyyy'
PASSWD='zzzz'
DuongDan='/var/backup/mysql/'
# Kiem tra goi expect da duoc cai dat chua
pack1="/var/cache/apt/archives/expect*"
if ! [ -f $pack1 ]
then
echo "Cai dat goi zip"
sudo apt-get install expect -y
fi
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

