#!/bin/bash
nameSRV=`hostname`
ngay=`eval date +%d%m%Y-%H%M%S`
cd /var/cache/apt/archives/
tar -cvf /root/"$nameSRV""_""$ngay""_package".tar *deb
echo " Finish!!!"
#
# Khai bao duong dan vao day
# find $backup_dir -ctime 7 -type f -delete
