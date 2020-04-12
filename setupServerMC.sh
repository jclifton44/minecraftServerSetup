wget 'https://minecraft.azureedge.net/bin-linux/bedrock-server-1.14.32.1.zip'
mkdir /opt/minecraftServer
mkdir bedrock-server
cp bedrock-server-1.14.32.1.zip bedrock-server/
cd bedrock-server
unzip 'bedrock-server-1.14.32.1.zip'
cd ../
cp -r bedrock-server /opt/minecraftServer/
cp checkServicesMC.sh /usr/bin/checkServicesMC
cat /etc/crontab | grep checkServicesMC
if [ $? -ne '0' ];
then
echo "*/5 * * * *       root    checkServicesMC" >> /etc/crontab
fi

