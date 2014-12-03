#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 17`
Nhieu2=`openssl rand -hex 23`
filepass="/root/password/"$ngay""_""pass_mysql".txt"

ThuMuc1="/var/lib/backups/mysql/"
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

mysqldump --opt -u root -p740c3665e223d1e780f9 --all-databases | zip -P $MatKhau > "$ThuMuc1$nameSRV$ngay".sql.zip
