cd /opt/minecraftServer/bedrock-server
DATE_EPOCH=$(date +%s)
BACKUP_DIR="/opt/minecraftServer/mcWorldData/"
mkdir ${BACKUP_DIR}/latest/
mkdir ${BACKUP_DIR}/recent/
echo $?
echo "VALUE"
ps ax | grep "bedrock_server" | grep -v grep
if [ "$?" -ne 0 ];
then
	echo "NOT RUNNING."
	echo "STARTING..."
	cd /opt/minecraftServer/bedrock-server
	./bedrock_server&
	echo ${DATE_EPOCH} >> uptime
else 
	#server running
	PID_VALUE=$(ps -ax | grep bedrock_server | awk {'print$1'} | head -n 1)
	mkdir ${BACKUP_DIR}recent/${PID_VALUE}
	rm -rf ${BACKUP_DIR}recent/${PID_VALUE}/*
	rm -rf ${BACKUP_DIR}latest/*
	tar -czvf ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar /opt/minecraftServer/bedrock-server/worlds
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}recent/${PID_VALUE}/
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}latest/
	rm ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar
	cd ${BACKUP_DIR}recent/
	find ${BACKUP_DIR}recent/ -mtime +0 -exec rm -rf {} \;

fi
exit

