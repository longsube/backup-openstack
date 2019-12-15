#!/bin/bash
PASSWD='DATA@!2o016'
ngay=`eval date +%d%m%Y`
#time=$ngay-170001
time=31052017-170001
pass_file='/root/controller1.hn.vnpt_'$time'_pass_mysql.txt'

function download_backup() {
    /usr/bin/expect - << EOF
    set timeout -1
    spawn wget --user=vnptcloud --ask-password --no-check-certificate https://123.31.17.134/sftp/mysql_backup/controller1.hn.vnpt_$time.sql.zip
        expect "Password for user ‘vnptcloud’"
        send "$PASSWD\n"
        expect "root@u-vm1:~#"
EOF


    /usr/bin/expect - << EOF
    set timeout -1
    spawn wget --user=vnptcloud --ask-password --no-check-certificate https://123.31.17.134/sftp/mysql_backup/controller1.hn.vnpt_$time\_pass_mysql.txt
        expect "Password for user ‘vnptcloud’"
        send "$PASSWD\n"
        expect "root@u-vm1:~#"
EOF
}

function extract_backup() {
    pass_file=$(<$1)
    pass=${pass_file:6:20}
    echo $pass
    unzip -P $pass controller1.hn.vnpt_$time.sql.zip
}

download_backup
sleep 5
extract_backup $pass_file
if [ $? -eq 0 ]
then
    echo "Thanh cong"
else
    echo "That bai"
fi
