UPDATED_VERSION="1.14.60.5"
echo "ca_directory=/etc/ssl/certs" >> /etc/wgetrc
wget "https://minecraft.azureedge.net/bin-linux/bedrock-server-${UPDATED_VERSION}.zip"
HOSTED_BACKUP="/var/www/html/hosted/"
cp checkServicesMC.sh /usr/bin/checkServicesMC
cp dailyRestoreMC.sh /usr/bin/dailyRestoreMC
mkdir /opt/minecraftServer
cp bedrock-server-${UPDATED_VERSION}.zip /opt/minecraftServer/
cd /opt/minecraftServer
mkdir bedrock-server
mkdir /mcWorldData
cp bedrock-server-${UPDATED_VERSION}.zip bedrock-server/
cd bedrock-server
unzip "bedrock-server-${UPDATED_VERSION}.zip"
cd ../
ln -s /opt/minecraftServer/mcWorldData ${HOSTED_BACKUP}
cp -r bedrock-server /opt/minecraftServer/
cat /etc/crontab | grep checkServicesMC
if [ $? -ne '0' ];
then
echo "*/5 * * * *       root    checkServicesMC" >> /etc/crontab
fi



cat /etc/crontab | grep "dailyRestoreMC"
if [ $? -ne '0' ];
then
echo "0 8 * * *       root    dailyRestoreMC" >> /etc/crontab
fi


