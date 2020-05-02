cd /opt/minecraftServerJavaSpigot/
DATE_EPOCH=$(date +%s)
BACKUP_DIR="/opt/minecraftServerJavaSpigot/mcWorldData/"
mkdir ${BACKUP_DIR}/latest/
mkdir ${BACKUP_DIR}/recent/
echo $?
ps ax | grep "spigot" | grep -v grep
if [ "$?" -ne 0 ];
then
	echo "NOT RUNNING."
	echo "STARTING..."
	cd /opt/minecraftServerJavaSpigot/
	java -Xmx1024M -Xms1024M -jar -XX:+UseConcMarkSweepGC spigot*.jar nogui
	echo ${DATE_EPOCH} >> uptime
else 
	echo "SERVER RUNNING!

fi

