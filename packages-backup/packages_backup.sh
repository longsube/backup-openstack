#!/bin/bash
nameSRV=`hostname`
ngay=`eval date +%d%m%Y-%H%M%S`
backup_folder="/var/backup/packages/"

# Kiem tra goi tar da duoc cai dat chua
pack1="/var/cache/apt/archives/tar*"
if ! [ -f $pack1 ]
then
echo "Cai dat goi tar"
sudo apt-get install tar -y
fi

if ! [ -d $backup_folder ]
then
mkdir -p $backup_folder
fi

file_name="$backup_folder""$nameSRV""_""$ngay""_packages"
cd /var/cache/apt/archives/
tar -cvf "$file_name".tar *deb

echo " Finish!!!"

