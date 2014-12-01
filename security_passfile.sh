
set timeout 5

set pass [lindex $argv 0]

set password [lindex $argv 1]
cd /root/backup/config

spawn ccrypt *.tar

expect "key"

send "$pass\r";

expect "key"

send "$password\r";

interact
