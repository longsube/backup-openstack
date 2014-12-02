
set timeout 20
proc check_link {link} {

    spawn ccrypt $link
    expect "key";
    send "Vdc1T@!d3m0\r"
    expect "key";
    send "Vdc1T@!d3m0\r"

    expect eof
}

set fp [open link.txt r]
while {[gets $fp line] != -1} {
    check_link $line
}
close $fp
