apt-get install make gcc
apt-get install unzip
#update to ssl 1.1.1
SSLName="openssl-1.1.1f.tar.gz"
wget "https://www.openssl.org/source/$SSLName.sha256"
wget "https://www.openssl.org/source/$SSLName"

echo "$(cat ${SSLName}.sha256) $SSLName" | sha256sum --check
if [ $? -ne 0 ];
then
	echo "Checksums do not match. Exiting..."
	exit
fi
exit
tar -zxf 'openssl-1.1.1f.tar.gz'
cd openssl-1.1.1f
./config
make
make test
mkdir ~/tmp
cp -r /usr/bin/openssl ~/tmp
make install
ln -s /usr/local/bin/openssl /usr/bin/openssl
ldconfig
cd ../
wget 'https://minecraft.azureedge.net/bin-linux/bedrock-server-1.14.32.1.zip'
unzip 'bedrock-server-1.14.32.1.zip'
