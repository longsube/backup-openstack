#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
HOST='172.16.69.161'
USER='admin'
PASSWD='a'
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 17`
Nhieu2=`openssl rand -hex 23`
filepass=""$ngay""_""pass".txt"
ThuMuc1="/root/backup/config/"
ThuMuc2="/root/password/"

pack1="/var/cache/apt/archives/zip*"
if ! [ -f $pack1 ]
then
sudo apt-get install zip -y
fi
pack2="/var/cache/apt/archives/expect*"
if ! [ -f $pack2 ]
then
sudo apt-get install expect -y
fi

echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi

echo $Nhieu1$MatKhau$Nhieu2 >> $ThuMuc2$filepass

index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < path.txt
for i in "${MYARRAY[@]}";
do
arr=$(echo $i | tr "/" "_")
tenfile="$nameSRV""_""$ngay""$arr".zip
   zip  -P $MatKhau -r $ThuMuc1$tenfile $i


cp $ThuMuc2$filepass $ThuMuc1$filepass
cd $ThuMuc1
/usr/bin/expect - << EOF
   spawn sftp $USER@$HOST
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $filepass\r"
        expect "sftp>"
        send "put \r"
        expect "sftp>"
        send "exit\r"
        interact
EOF

done

echo " Finish!!!!!"
