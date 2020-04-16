cd /opt/minecraftServer/bedrock-server
DATE_EPOCH=$(date +%s)
BACKUP_DIR="/opt/minecraftServer/mcWorldData/"
ps ax | grep "bedrock_server" 
echo $?
echo "VALUE"
if [ "$?" -ne 0 ];
then
	echo "NOT RUNNING."
	echo "STARTING..."
	cd /opt/minecraftServer/bedrock-server
	./bedrock_server&
else 
	#server running
	PID_VALUE=$(ps -ax | grep bedrock_server | awk {'print$1'} | head -n 1)
	mkdir ${BACKUP_DIR}${PID_VALUE}
	rm -rf ${BACKUP_DIR}${PID_VALUE}/*
	tar -czvf ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar /opt/minecraftServer/bedrock-server/worlds
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar ${BACKUP_DIR}${PID_VALUE}/
	rm ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar
fi
exit

