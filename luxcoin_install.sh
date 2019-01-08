#!/bin/bash

wget https://github.com/LUX-Core/lux/archive/v5.2.3.tar.gz
mkdir -p lux && tar xf tarfilename -C ./lux --strip-components=1
sudo find lux/ -type f -iname "*.sh" -exec chmod +x {} \;
cd lux/
sudo sh ./depends/install-dependencies.sh
sudo ./autogen.sh && sudo ./configure --disable-tests --without-gui && sudo make clean && sudo make -j$(nproc)
cd $HOME
mkdir ~/.lux
CONFIGFOLDER=/root/.lux
CONFIG_FILE=lux.conf
NODEIP=$(curl -s4 icanhazip.com)
PRIVATE_KEY="$1"

function create_config() {
 RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $CONFIGFOLDER/$CONFIG_FILE
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcallowip=127.0.0.1
listen=1
server=1
daemon=1
maxconnections=100
externalip=$NODEIP
masternodeprivkey=$PRIVATE_KEY
staking=0
masternode=1
bind=$NODEIP
masternodeaddr=$NODEIP:26969
port=26969
#--------------------LUXCORE--------------------------------------------------------------------------------

EOF
}
create_config()
