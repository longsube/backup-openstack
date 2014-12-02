
set timeout 20
proc check_link {link} {

    spawn ccrypt $link
    expect "key";
    send "123456a@\r"
    expect "key";
    send "123456a@\r"

    expect eof
}

set fp [open link.txt r]
while {[gets $fp line] != -1} {
    check_link $line
}
close $fp
