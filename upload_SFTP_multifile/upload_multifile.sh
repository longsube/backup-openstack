Folder="/root/hafolder"
ls -1t $Folder > link.txt
index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < link.txt


HOST='172.16.69.161'
USER='admin'
PASSWD='a'
for i in "${MYARRAY[@]}";
do
# Doi ten duong dan khi thuc hien
FILE=`ls -1t $DuongDan | head -1`

/usr/bin/expect - << EOF
   spawn sftp $USER@$HOST
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $i\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
done
