#!bin/bash
echo " Start restore!!!!!!"
directory1="etc"
directory2="var"
find . -maxdepth 1 -name "*.zip" -exec zip -xvf {} \;
if [ -d $directory1 ]
then
rsync -rv etc/ /etc/
fi
if [ -d $directory2 ]
then
rsync -rv var/ /var/
fi
echo " Finish!!!!!!!"
