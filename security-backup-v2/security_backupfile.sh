#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`

pack1="/var/cache/apt/archives/ccrypt*"
if ! [ -f $pack1 ]
then
sudo apt-get install ccrypt -n
fi

pack2="/var/cache/apt/archives/expect*"
if ! [ -f $pack1 ]
then
sudo apt-get install expect -n
fi

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
   
    tar -cf /root/backup/config/"$nameSRV""_""$ngay""$arr".tar $i
    
     
    
done
expect security_passfile.sh 123.abc 123.abc
echo " Finish!!!!!!!!!!!"
#find $directory -ctime 7 -type f -delete
