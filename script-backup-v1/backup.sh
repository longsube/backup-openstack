#!/bin/bash
ngay=`eval date +%d%m%Y-%H%M%S`
mkdir -p /root/backup/{keystone,glance,nova,neutron,cinder}
cd /etc
tar -cf /root/backup/keystone/"keystone_"$time.tar keystone 
tar -cf /root/backup/glance/"glance_"$time.tar glance 
tar -cf /root/backup/nova/"nova_"$time.tar nova
tar -cf /root/backup/neutron/"neutron_"$time.tar neutron 
tar -cf /root/backup/cinder/"cinder_"$time.tar cinder

echo " Finish!!!"
echo "Your backup files in /root/backup "


