Backup file and package
===========
# A. Backup file
## I. Mục tiêu 
  Mục tiêu của bài viết lập lịch cho khoảng thời gian backup file trong hệ thống. 
  
  Thời gian lập lịch sẽ là trong 1 ngày cập nhật 2 lần vào lúc 13h và 24h. Trong thư mục chứa file backup chỉ tồn tại 7 backup mới nhất.

## II. Các bước thực hiện
  B1: Tải file shell backup và file path.txt theo đường link sau. Đặt file shell vào thư mục bạn lựa chọn ở đấy mình đặt trong thư mục /root. 
  
```sh
git clone https://github.com/hocchudong/backup-openstack.git
```
  B2: Cài đặt Cron trên Ubuntu: 

    # apt-get updte 
    # apt-get install cron 
  
  B3: Sau khi cài đặt chạy lệnh sau: 
  
    # crontab -e 
  
  Nếu là lần đầu chạy lệnh    crontab -e sẽ hiện ra mục để chọn chương trình mở file mậc định. Mình sử dụng nano để mở ứng dụng lên sẽ chọn là 2. 
  
  B4: Thêm dòng sau vào file: 
  
    0 0,13 * * * bash /root/backup.sh 
    
  B5: Chay file script. Hoàn thành quá trình backup file


# B. Restore lại hệ thống
B1. Tải script theo đường dẫn

```sh
https://raw.githubusercontent.com/hocchudong/backup-openstack/master/restore.sh
```

B2. Đưa script và các file cần backup vào 1 thư mục 

B3. Chạy script để restore lại hệ thống

# C. Backup package

## I. Mục tiêu 
  Mục tiêu của bài viết lập lịch cho khoảng thời gian backup các packgage cài đặt trong thư mục /var/cache/apt/archives/
  
  Thời gian lập lịch sẽ là trong 1 ngày cập nhật 2 lần vào lúc 13h và 24h. Trong thư mục chứa file backup chỉ tồn tại 7 backup mới nhất.

## II. Các bước thực hiện
  B1: Tạo thư mục chứa file backup như đường dẫn sau: 
  
    /root/backupackage
  
  B2: Tải file shell backup theo đường link sau. Đặt file shell vào thư mục bạn lựa chọn ở đấy mình đặt trong thư mục /root. 
  
    wget https://raw.githubusercontent.com/hocchudong/backup-openstack/master/restore.sh
	
  B3: chỉnh sửa crontab
 ```sh 
 0 0,13 * * * bash /root/backup.sh
``` 
    
  B6: Chay file script. Hoan thanh qua trinh backup 


# D. Backup SQL trong Windows
## B1: Tạo file backup SQL 
Tải file sqlbackup.sql theo đường dẫnsau

     https://raw.githubusercontent.com/hocchudong/backup-openstack/master/backup_sql_windows/sqlbackup.sql

Nội dung file:

    USE portal; 
    GO
    DECLARE @path VARCHAR(256) -- path for backup files  
    DECLARE @fileDate VARCHAR(20) -- used for file name
    DECLARE @fileName VARCHAR(256) -- filename for backup 
    SET @path = 'D:\SQL_Backup\'  
    SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),':','')
    SET @fileName = @path + 'portal' + '_' + @fileDate + '.BAK'  
    BACKUP DATABASE portal
    TO DISK = @fileName
    GO
     
Khi chạy đoạn scirpt trong SQL SERVER  các database sẽ được nén lại thành các file .BAK với tên là đường dẫn của file và được lưu ở thư mục D:\SQL_Backup\

##B2: Tạo lịch trình backup SQL
Để chạy script trên cmd ta tải thêm backup.dat theo đường dẫn

     https://raw.githubusercontent.com/hocchudong/backup-openstack/master/backup_sql_windows/backup.bat
 Nội dung file: 

@ECHO OFF 
sqlcmd -S localhost -i C:\SQLScript\sqlbackup.sql

Để chạy câu lệnh trên theo một lịch trình được định nghĩa sẵn ta dùng schedule task trong windown. Cấu hình task schedule


Mở task schedule lên và chọn create task để khởi tạo một task mới

<img src=http://i.imgur.com/QcQSpIm.png width="60%" height="60%" border="1">

Đặt tên cho task, tích chọn chức năng chạy task ngay cả khi user logout ra khỏi hệ thống

<img src=http://i.imgur.com/IryRgUv.png width="60%" height="60%" border="1">

Chuyển sang tab Triggers chọn NEW và lập lịch chạy script, giả sử trường hợp này ta chạy scirpt hàng ngày vào lúc 12:00:00 AM

<img src=http://i.imgur.com/7kJNNGu.png width="60%" height="60%" border="1">

Thẻ Action chọn Start Program và Browers đến thư mục chứa script cần chạy

<img src=http://i.imgur.com/5DhK6cN.png width="60%" height="60%" border="1">

Cuối cùng tại tab Settings, tích chọn " Run task as soon as possible a schedule is start missed"

<img src=http://i.imgur.com/SB6BzwA.png width="60%" height="60%" border="1">

Click OK để hoàn tất

## B3: Xóa các file log, backup cũ
 
Để xóa file backp cũ ta tải về script theo đường dẫn

    https://raw.githubusercontent.com/hocchudong/backup-openstack/master/backup_sql_windows/del_old_bk.dat

Xóa file log ta chạy scirpt theo đường dẫn

    https://raw.githubusercontent.com/hocchudong/backup-openstack/master/backup_sql_windows/del_log_SQL.dat

##B4: Upload lên SFTP server

Chạy file scipt theo đường dẫn sau để upload lên sftp server

    https://raw.githubusercontent.com/hocchudong/backup-openstack/master/backup_sql_windows/Upload_SFTP_3.dat
