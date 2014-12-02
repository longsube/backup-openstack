DuongDanFile="/var/backup/config/"
ls -1t $DuongDanFile > duongdanfile.txt
index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < duongdanfile.txt


HOST='10.30.0.111'
USER='ftp_client'
PASSWD='Vdc1T@!d3m0'
for i in "${MYARRAY[@]}";
do
# Doi ten duong dan khi thuc hien
# FILE=`ls -1t $DuongDan | head -1`
DuongDanBackup='config_backup'
/usr/bin/expect - << EOF
   spawn sftp -P 9225 $USER@$HOST:$DuongDanBackup
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $DuongDanFile$i\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
done
