## Backup file security
### B1: Chuẩn bị
Đứng trên 1 thư mục tải các file cần thiết:

    wget https://raw.githubusercontent.com/hocchudong/backup-openstack/master/security-backup-v2/path.txt
    wget https://github.com/hocchudong/backup-openstack/blob/master/security-backup-v2/security_backupfile.sh
    wget https://github.com/hocchudong/backup-openstack/blob/master/security-backup-v2/security_passfile.sh
    
### B2: Backup file
 Mật khẩu nén file trong file security_backupfile.sh
Chỉnh sửa mật khẩu nén file

    vi security_backupfile

Tìm đến dòng "expect security_passfile.sh 123.abc 123.abc " thay 123.abc thành mật khẩu của bạn. ví dụ

    expect security_passfile.sh P@ssw0rd P@ssw0rd
    
Tiến hành backup file

    bash security_passfile.sh

Tất cả các file backup nằm trong thư mục /root/backup/config.
    
