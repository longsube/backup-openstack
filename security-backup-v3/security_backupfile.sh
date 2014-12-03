#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 17`
Nhieu2=`openssl rand -hex 23`
filepass="/root/password/"$ngay""_""pass".txt"

ThuMuc1="/root/backup/config/"
ThuMuc2="/root/password/"
echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi

echo $Nhieu1$MatKhau$Nhieu2 >> $filepass

index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < path.txt
for i in "${MYARRAY[@]}";
do
arr=$(echo $i | tr "/" "_")
tenfile="$ThuMuc1""$nameSRV""_""$ngay""$arr"
   zip  -P $MatKhau -r "$tenfile".zip $i

done

echo " Finish!!!!!!!!!!!"
