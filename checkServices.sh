ps ax | grep "bedrock_server" | grep bin
if [ $? -ne '0' ];
then
	cd /opt/minecraftServer
	bedrock_server.sh&
fi

