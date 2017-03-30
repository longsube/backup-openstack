#!/bin/bash
#Khai bao cac bien
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`

ThuMuc1="/var/backup/config/"

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
   zip  -r "$tenfile".zip $i

done

echo " Finish!!!!!!!!!!!"

