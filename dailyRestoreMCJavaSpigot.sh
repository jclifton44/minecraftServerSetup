cd /opt/minecraftServer/bedrock-server
DATE_EPOCH=$(date +%s)
BACKUP_DIR="/opt/minecraftServerJavaSpigot/mcWorldData/"
mkdir ${BACKUP_DIR}monthly/
cp ${BACKUP_DIR}/latest/* ${BACKUP_DIR}monthly/
find ${BACKUP_DIR} -type f -mtime +15 -exec rm -rf {} \;
