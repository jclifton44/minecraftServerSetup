cd /opt/minecraftServer/bedrock-server
DATE_EPOCH=$(date +%s)
BACKUP_DIR="/opt/minecraftServer/mcWorldData/"
mkdir ${BACKUP_DIR}/monthly/
cp ${BACKUP_DIR}/latest/* ${BACKUP_DIR}/monthly/
find ${BACKUP_DIR} -type f -mtime +30 -exec rm -rf {} \;
echo "VALUE"
