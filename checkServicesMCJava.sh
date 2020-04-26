cd /opt/minecraftServerJava/
DATE_EPOCH=$(date +%s)
BACKUP_DIR="/opt/minecraftServerJava/mcWorldData/"
mkdir ${BACKUP_DIR}/latest/
mkdir ${BACKUP_DIR}/recent/
echo $?
ps ax | grep "bedrock_server" | grep -v grep
if [ "$?" -ne 0 ];
then
	echo "NOT RUNNING."
	echo "STARTING..."
	cd /opt/minecraftServerJava/
	java -Xmx1024M -Xms1024M -jar server.java nogui
	echo ${DATE_EPOCH} >> uptime
else 
	#server running
	PID_VALUE=$(ps -ax | grep bedrock_server | awk {'print$1'} | head -n 1)
	mkdir mcWorld
	mkdir ${BACKUP_DIR}recent/${PID_VALUE}
	rm -rf ${BACKUP_DIR}recent/${PID_VALUE}/*
	rm -rf ${BACKUP_DIR}latest/*
	rm -rf mcWorld/*
	cp -r DIM* /mcWorld
	cp -r level.dat /mcWorld
	cp -r region /mcWorld
	tar -czvf ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar mcWorld
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}recent/${PID_VALUE}/
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}latest/
	rm ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar
	cd ${BACKUP_DIR}recent/
	find ${BACKUP_DIR}recent/ -mtime +0 -exec rm -rf {} \;

fi
exit

