#!/bin/bash
FOLDER_PATH="/root/.exclusivecoin"
CONF_FILE_PATH="/root/.exclusivecoin/exclusivecoin.conf"
NODEIP=$(curl -s4 icanhazip.com)
COIN_PORT=23230
MASTERNODE_PRIVATE_KEY="$1"

function update_config() {
 RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
 RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $CONF_FILE_PATH
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
logintimestamps=1
maxconnections=64
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$MASTERNODE_PRIVATE_KEY
EOF
}
mkdir $FOLDER_PATH
touch $CONF_FILE_PATH
update_config
exclusivecoind -daemon
