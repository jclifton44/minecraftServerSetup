apt-get install default-jre
mkdir /opt/minecraftServerJava
cd /opt/minecraftServerJava
wget "https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar"
HOSTED_BACKUP="/var/www/html/hosted/"
cp checkServicesMCJava.sh /usr/bin/checkServicesMCJava
cp dailyRestoreMCJava.sh /usr/bin/dailyRestoreMCJava
mkdir /mcWorldData
cd ../
ln -s /opt/minecraftServerJava/mcWorldData ${HOSTED_BACKUP}
cat /etc/crontab | grep checkServicesMCJava
ufw allow 25565
ufw disable
ufw enable
if [ $? -ne '0' ];
then
echo "*/5 * * * *       root    checkServicesMCJava" >> /etc/crontab
fi



cat /etc/crontab | grep dailyRestoreMCJava
if [ $? -ne '0' ];
then
echo "0 8 * * *       root    dailyRestoreMCJava" >> /etc/crontab
fi


