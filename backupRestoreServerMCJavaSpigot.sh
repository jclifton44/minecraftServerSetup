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
	#server running
	cd /opt/minecraftServerJavaSpigot/
	echo "RUNNING!"
	PID_VALUE=$(ps -ax | grep spigot | awk {'print$1'} | head -n 1)
	mkdir mcWorldData
	mkdir mcWorldData/recent
	mkdir mcWorldData/latest
	mkdir mcWorldData/monthly
	mkdir worldRestore
	mkdir ${BACKUP_DIR}recent/${DATE_EPOCH}
	rm -rf ${BACKUP_DIR}latest/*
	rm -rf worldRestore/*
	cp -r world*_nether worldRestore/
	cp -r world*_the_end worldRestore/
	cp -r world*/level.dat worldRestore/
	cp -r world*/region worldRestore/
	tar -czvf ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar worldRestore
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}recent/${DATE_EPOCH}/
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}latest/
	rm ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar
	cd ${BACKUP_DIR}recent/
	find ${BACKUP_DIR}recent/ -mtime +0 -exec rm -rf {} \;

fi

