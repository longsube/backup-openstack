#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 2`
Nhieu2=`openssl rand -hex 3`

ThuMuc1="/var/backup/mysql/"
ThuMuc2="/var/MYSQLpass/"
filepass=""$ThuMuc2""$nameSRV""_""$ngay""_""pass_mysql".txt"
echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi

echo "V"$Nhieu1"D"$MatKhau"C"$Nhieu2 >> $filepass
mysqldump --opt -u root  --all-databases > $ThuMuc1"$nameSRV""_""$ngay".sql
cd $ThuMuc1
zip -P $MatKhau "$nameSRV""_""$ngay".sql.zip "$nameSRV""_""$ngay".sql
sleep 10
rm -f "$nameSRV""_""$ngay".sql
sleep 10
find $ThuMuc1 -ctime 7 -type f -delete
