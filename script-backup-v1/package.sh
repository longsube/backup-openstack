#!/bin/bash
nameSRV=`hostname`
ngay=`eval date +%d%m%Y-%H%M%S`
cd /var/cache/apt/archives/
tar -cvf /root/"package_"$nameSRV$ngay.tar *deb
echo " Finish!!!"
