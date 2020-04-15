cd /opt/minecraftServer/bedrock-server
DATE_EPOCH=$(date +%s)
ps ax | grep "bedrock_server" | grep bedrock-server
if [ $? -ne '0' ];
then
	cd /opt/minecraftServer/bedrock-server
	./bedrock_server&
else 
	#server running
	PID_VALUE=$(ps -ax | grep bedrock_server | awk {'print$1'} | head -n 1)
	tar -czvf ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar /opt/minecraftServer/bedrock-server/worlds
	cp ${DATE_EPOCH}_${PID_VALUE}MCworlds.tar /var/www/html/hosted/
fi
exit

