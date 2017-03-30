#!bin/bash
echo " Start restore!!!!!!"
echo -e “please put password:  \c ”
read word

find . -maxdepth 1 -name "*.zip" -exec  unzip -P $word *.zip \;

directory1="etc"
directory2="var"
find . -maxdepth 1 -name "*.tar" -exec tar -xvf {} \;
if [ -d $directory1 ]
then
rsync -rv etc/ /etc/
fi
if [ -d $directory2 ]
then
rsync -rv var/ /var/
fi
