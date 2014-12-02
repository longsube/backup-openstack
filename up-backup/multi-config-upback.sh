DuongDanFile="/var/backup/config/"
ls -1t $DuongDanFile > duongdanfile.txt
index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < duongdanfile.txt

# Sua cac thong so truoc khi thuc thi
HOST='x.x.x.x'
USER='client'
PASSWD='123456a@'
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
