**Hướng dẫn sử dụng script Backup MySQL và lưu trữ lên SFTP server**

*Môi trường thực hiện:*
 - OS: Ubuntu 14.04.5, kernel 4.4.0-142-generic
 - Ứng dụng: MariaDB version 15.1 Distrib 10.0.38-MariaDB

 *Kịch bản thực hiện:* 
 - Script thực hiện dump mysql database, nén với mật khẩu được tạo ngẫu nhiên.
 - File database nén và mật khẩu nén được đặt vào các thư mục riêng biệt, với tên được đánh theo ngày thực hiện backup.
 - File backup chỉ được lưu giữ 7 ngày.

## 1. Cài đặt gói
 - Cài đặt MariaDB server
```
apt-get update
apt-get -y install mariadb-server
```

 - Trong quá trình cài MariaDB, hệ thống yêu cầu người dùng nhập mật khẩu vào ô sau:
 ![mysql set password](/images/mysql_password.png)

 - Nhập mật khẩu `Welcome123` và tiếp tục.

 - Tại thư mục /root, tạo file `.my.cnf` để login MySql không hỏi password:
```
touch /root/.my.cnf
```

 - File `.my.cnf` có nội dung:
```
[client]
user = root
password = Welcome123
```

 - Đăng nhập bằng tài khoản root vào MariaDB để tạo database test. Sau đó gõ lệnh exit để thoát.

```
root@controller:~# mysql -u root
 Welcome to the MariaDB monitor.  Commands end with ; or \g.
 Your MariaDB connection id is 29
 Server version: 5.5.47-MariaDB-1ubuntu0.14.04.1 (Ubuntu)

 Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.

 Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

 MariaDB [(none)]> CREATE DATABASE test_db;
 MariaDB [(none)]> exit;
```

 - Cài đặt package zip (để thực hiện nén file)
```
apt-get install zip -y
```

## 2. Triển khai script Backup MySQL
 - Download script và đặt tại thư mục /root
```
wget -O /root/backup_mysql.sh https://raw.githubusercontent.com/longsube/backup-openstack/master/mysql-backup/backup_mysql.sh
chmod +x /root/backup_mysql.sh
```

 - Nội dung script:
```
#!/bin/bash

# Khai bao dinh dang ngay-thang-nam thuc hien backup
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 2`
Nhieu2=`openssl rand -hex 3`

# Khai bao thu muc chua file backup va thu muc chua mat khau giai nen file backup
ThuMuc1="/var/backup/mysql/"
ThuMuc2="/var/MYSQLpass/"
filepass=""$ThuMuc2""$nameSRV""_""$ngay""_""pass_mysql".txt"

# Khoi tao thu muc chua file backup va file chua mat khau nen
echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi

# Kiem tra goi zip da duoc cai dat chua
pack1="/var/cache/apt/archives/zip*"
if ! [ -f $pack1 ]
then
echo "Cai dat goi zip"
sudo apt-get install zip -y
fi

# Thuc hien backup MySQL database
echo "V"$Nhieu1"D"$MatKhau"C"$Nhieu2 >> $filepass
mysqldump --opt -u root  --all-databases > $ThuMuc1"$nameSRV""_""$ngay".sql

# Thuc hien nen và dat mat khau cho file backup
cd $ThuMuc1
zip -P $MatKhau "$nameSRV""_""$ngay".sql.zip "$nameSRV""_""$ngay".sql
sleep 10

# Go bo file backup goc, chi giu lai file nen
rm -f "$nameSRV""_""$ngay".sql
sleep 10

# Go bo cac ban backup da ton tai hon 7 ngay
find $ThuMuc1 -ctime 7 -type f -delete
```

 - Thực hiện script trên máy chủ:
```
bash /root/backup_mysql.sh
```

## 3. Kiểm thử
 - Như khai báo trong script, file backup nén đặt tại `/var/backup/mysql/` và file password giải nén đặt tại `/var/MYSQLpass/`. File backup được đặt tên như sau:
 `localhost.localdomain_15122019-051531.sql.zip`
  - `localhost.localdomain`: tên của máy chủ.
  - `15122019-051531`: thời gian thực hiện backup

 - Thử giải nén file backup vào thư mục `root`
 ```
 apt-get install unzip -y
 unzip [file.zip] -d /root
 ```
