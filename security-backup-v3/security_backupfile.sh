#!/bin/bash
#Khai bao cac bien
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 17`
Nhieu2=`openssl rand -hex 23`
filepass="/root/password/"$ngay""_""pass".txt"
ThuMuc1="/root/backup/config/"
ThuMuc2="/root/password/"

# Kiem tra goi zip da duoc cai dat chua
pack1="/var/cache/apt/archives/zip*"
if ! [ -f $pack1 ]
then
echo "Cai dat goi zip"
sudo apt-get install zip -y
fi
#Khoi tao thu muc chua file backup va file chua mat khau nen
echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi
# chen mat khau vao file
echo $Nhieu1$MatKhau$Nhieu2 >> $filepass

# Doc duong dan tu file path.txt
index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < path.txt
for i in "${MYARRAY[@]}";
do
# thay ky tu trong mang
arr=$(echo $i | tr "/" "_")
tenfile="$ThuMuc1""$nameSRV""_""$ngay""$arr"
# Thuc hien nen file
   zip  -P $MatKhau -r "$tenfile".zip $i

done

echo " Finish!!!!!!!!!!!"
