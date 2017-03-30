DuongDanFile="/var/MYSQLpass/"
ls -1t $DuongDanFile > /var/tools/up-back-v3/duongdanfile_mysql.txt
index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < /var/tools/up-back-v3/duongdanfile_mysql.txt


# Sua cac thong so truoc khi thuc thi
HOST='x.x.x.x'
USER='yyyyy'
PASSWD='zzzz'
# Kiem tra goi expect da duoc cai dat chua
pack1="/var/cache/apt/archives/expect*"
if ! [ -f $pack1 ]
then
echo "Cai dat goi zip"
sudo apt-get install expect -y
fi
for i in "${MYARRAY[@]}";
do
# Doi ten duong dan khi thuc hien
# FILE=`ls -1t $DuongDan | head -1`
DuongDanBackup='mysql_backup'
/usr/bin/expect - << EOF
set timeout -1
   spawn sftp  $USER@$HOST:$DuongDanBackup
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $DuongDanFile$i\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF
done
rm -rf $DuongDanFile

