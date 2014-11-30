#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
directory="/root/backup/config"
echo "Create folder backup"
if ! [ -d $directory ]
then
mkdir -p /root/backup/config
fi

index=0
while read line ; do
    MYARRAY[$index]="$line"
    index=$(($index+1))
done < path.txt

for i in "${MYARRAY[@]}";
do
arr=$(echo $i | tr "/" "_")

    for x in $arr
    do
    tar -cf /root/backup/config/"$nameSRV""_""$ngay""$x".tar $i
    done
    
done
echo " Finish!!!!!!!!!!!"
#find $directory -ctime 7 -type f -delete
