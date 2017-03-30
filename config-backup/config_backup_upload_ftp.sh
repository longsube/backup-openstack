#!/bin/bash

# Sua cac thong tin truoc khi thuc thi
DuongDanFile="/var/backup/config/"
backup_folder=`ls -1t $DuongDanFile | head -1`
# ls -1t $DuongDanFile > file_backup_link.txt
# index=0
# while read line ; do
#     MYARRAY[$index]="$line"
#     index=$(($index+1))
# done < file_backup_link.txt

# Sua cac thong so truoc khi thuc thi
HOST='x.x.x.x'
USER='yyyyy'
PASSWD='zzzz'
#for i in "${MYARRAY[@]}";
#do
# Doi ten duong dan khi thuc hien
# FILE=`ls -1t $DuongDan | head -1`
DuongDanFTP='config_backup'
/usr/bin/expect - << EOF
   spawn sftp -P 22 $USER@$HOST:$DuongDanFTP
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "mkdir $backup_folder\r"
        expect "sftp>"
        send "put -r $DuongDanFile$backup_folder\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
#done
