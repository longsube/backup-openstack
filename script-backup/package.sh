#!/bin/bash
hostname=`hostname`
date=`date +"%y%m%d-%H%M%S"`
cd /var/cache/apt/archives/
tar -cvf /root/"package_"$hostname$time.tar *deb
echo " Finish!!!"