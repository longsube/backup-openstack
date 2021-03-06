#!/bin/bash

# Khai bao dinh dang ngay-thang-nam thuc hien backup
nameSRV=`hostname`
ngay=`eval date +%d%m%Y-%H%M%S`
backup_folder="/var/backup/packages/""$nameSRV""_""$ngay/"

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


# Xuat thong tin ve phien ban cac package
output="$backup_folder""$nameSRV""_""$ngay""-info.txt"
printf 'HOSTNAME\n' > $output
cat /etc/hostname >> $output

printf '\n\nRELEASE\n'  >> $output
lsb_release -a >> $output

printf '\n\nKERNEL VERSION\n'  >> $output
uname -r >> $output

printf '\n\nMOUNT FILE SYSTEM\n'  >> $output
mount >> $output

printf '\n\nCRONTAB\n'  >> $output
for user in $(cut -f1 -d: /etc/passwd); do echo "CRONTAB CUA USER $user"; crontab -u $user -l; done >> $output

printf '\n\nINIT SERVICES\n'  >> $output
service --status-all >> $output

printf '\n\nIPTABLES RULES\n'  >> $output
printf '\nfilter\n'  >> $output
iptables -S >> $output
printf '\nnat\n'  >> $output
iptables -t nat -S >> $output
#printf '\n\nKERNEL PARAMETERS\n'  >> $output

printf '\n\nPACKAGES\n'  >> $output
dpkg -l >> $output

echo " Finish!!!"

