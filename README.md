Backup file and package
===========
# A. Backup file
## I. Mục tiêu 
  Mục tiêu của bài viết lập lịch cho khoảng thời gian backup file trong hệ thống. 
  
  Thời gian lập lịch sẽ là trong 1 ngày cập nhật 2 lần vào lúc 13h và 24h. Trong thư mục chứa file backup chỉ tồn tại 7 backup mới nhất.

## II. Các bước thực hiện
  B1: Tải file shell backup và file path.txt theo đường link sau. Đặt file shell vào thư mục bạn lựa chọn ở đấy mình đặt trong thư mục /root. 
  
```sh
git clone https://github.com/hocchudong/Backup-file-and-package.git
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

https://github.com/thanhha123/Backup-file-and-package/blob/master/restore.sh

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
  
    wget https://github.com/thanhha123/Backup-file-and-package/blob/master/backuppackage.sh
  
  B3: chỉnh sửa crontab
  
    0 0,13 * * * bash /root/backup.sh 
    
  B6: Chay file script. Hoan thanh qua trinh backup 

