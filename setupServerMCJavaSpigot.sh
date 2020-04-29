apt-get install default-jre
PORT_NUMBER="234"
mkdir /opt/minecraftServerJavaSpigot
cp checkServicesMCJavaSpigot.sh /usr/bin/checkServicesMCJavaSpigot
cp dailyRestoreMCJavaSpigot.sh /usr/bin/dailyRestoreMCJavaSpigot
cd /opt/minecraftServerJavaSpigot
wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
java -Xmx1G -Xms1G -jar BuildTools.jar
HOSTED_BACKUP="/var/www/html/hosted/"
mkdir /mcWorldData
cd ../
ln -s /opt/minecraftServerJavaSpigot/mcWorldData ${HOSTED_BACKUP}
#ufw allow ${PORT_NUMBER}
#ufw disable
#ufw enable
cat /etc/crontab | grep checkServicesMCJavaSpigot
if [ $? -ne '0' ];
then
echo "*/8 * * * *       root    checkServicesMCJavaSpigot" >> /etc/crontab
fi



cat /etc/crontab | grep dailyRestoreMCJavaSpigot
if [ $? -ne '0' ];
then
echo "0 8 * * *       root    dailyRestoreMCJavaSpigot" >> /etc/crontab
fi


