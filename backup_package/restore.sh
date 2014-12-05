#!bin/bash
echo " Start restore!!!!!!"
directory1="/var/cache/apt/archives/"
echo -e “please put password:  \c ”
read word

find . -maxdepth 1 -name "*.tar" -exec  unzip -P $word *.zip \;
if [ -d $directory1 ]
then
rsync -rv /var/ /var/cache/apt/archives/
fi
