#!/bin/bash
FOLDER_PATH="/root/.bitcoingreen"
CONF_FILE_PATH="/root/.bitcoingreen/bitcoingreen.conf"
NODEIP=$(curl -s4 icanhazip.com)
COIN_PORT=9333
MASTERNODE_PRIVATE_KEY="$1"

function update_config() {
 RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
 RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $CONF_FILE_PATH
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcport=9332
rpcallowip=127.0.0.1
logintimestamps=1
listen=1
server=1
daemon=1
maxconnections=256
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$MASTERNODE_PRIVATE_KEY
addnode=51.15.198.252
addnode=51.15.206.123
addnode=51.15.66.234
addnode=51.15.86.224
addnode=51.15.89.27
addnode=51.15.57.193
addnode=134.255.232.212
addnode=185.239.238.237
addnode=185.239.238.240
addnode=134.255.232.212
addnode=207.148.26.77
addnode=207.148.19.239
addnode=108.61.103.123
addnode=185.239.238.89
addnode=185.239.238.92
EOF
}
mkdir $FOLDER_PATH
touch $CONF_FILE_PATH
wget https://github.com/XeZZoR/scripts/raw/master/BITG/peers.dat -O bitg_peers.dat
cp bitg_peers.dat $FOLDER_PATH/peers.dat
update_config
bitcoingreend -daemon -conf=$CONF_FILE_PATH -datadir=$FOLDER_PATH
