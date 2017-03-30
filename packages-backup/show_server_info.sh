#!/bin/bash

HOSTNAME=`cat /etc/hostname`
#DATE=`eval date +%d%m%Y-%H%M%S`
DATE=`eval date +%Y%m%d-%H%M%S`
output="$HOSTNAME-$DATE-info.txt"

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