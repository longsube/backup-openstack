**Hướng dẫn sử dụng script Backup các package đã cài đặt trong OS**

*Môi trường thực hiện:*
 - OS: Ubuntu 14.04.5, kernel 4.4.0-142-generic

 *Kịch bản thực hiện:* 
 - Script thực hiện backup các gói cài đặt.
 - Các gói cài đặt được nén và lưu trữ.
 - Thông tin về các gói cài đặt được lưu trữ cùng thư mục với file nén

## 1. Cài đặt gói
 - Cài đặt gói `tar`
```
apt-get update
apt-get install -y tar
```

## 2. Triển khai script Backup package
 - Download script và đặt tại thư mục /root
```
wget -O /root/package_backup.sh https://raw.githubusercontent.com/longsube/backup-openstack/master/packages-backup/packages_backup.sh
chmod +x /root/package_backup.sh
```

 - Nội dung script:
```
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
```

 - Thực hiện script trên máy chủ:
```
bash /root/package_backup.sh
```

## 3. Kiểm thử
 - Như khai báo trong script, thư mục backup đặt tại `/var/backup/packages/`. 
 `localhost.localdomain_15122019-053940`
  - `localhost.localdomain`: tên của máy chủ.
  - `15122019-053940`: thời gian thực hiện backup

 - Thư mục bao gồm 2 file:

  - `localhost.localdomain_15122019-053940_packages.tar`: chứa file nén backup
  - `localhost.localdomain_15122019-053940-info.txt`: chứa thông tin về các bản backup
