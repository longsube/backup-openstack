#!/bin/bash
# Khai bao bien
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

# Kiem tra goi cai dat zip
pack1="/var/cache/apt/archives/zip*"
if ! [ -f $pack1 ]
then
sudo apt-get install zip -y
fi
#Kiem tra goi cai dat expect
pack2="/var/cache/apt/archives/expect*"
if ! [ -f $pack2 ]
then
sudo apt-get install expect -y
fi

#Khoi tao file backup va file chua password
echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi

# Ghi mat khau vao file
echo $Nhieu1$MatKhau$Nhieu2 >> $ThuMuc2$filepass

# Doc file path.txt chua cac duong dan backup
index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < path.txt
for i in "${MYARRAY[@]}";
do
# Thay cac ky tu trong duong dan
arr=$(echo $i | tr "/" "_")
tenfile="$nameSRV""_""$ngay""$arr".zip
# Nen file
   zip  -P $MatKhau -r $ThuMuc1$tenfile $i

# copy file pass vao trong thu muc can day len SFTP server
cp $ThuMuc2$filepass $ThuMuc1$filepass
cd $ThuMuc1
# Ket noi SFTP va thuc hien upload file
/usr/bin/expect - << EOF
   spawn sftp $USER@$HOST
        expect "password:"
        send "$PASSWD\r"
        expect "sftp>"
        send "put $filepass\r"
        expect "sftp>"
        send "exit\r"
        interact
EOF

done

echo " Finish!!!!!"
