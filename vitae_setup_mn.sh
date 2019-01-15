#!/bin/bash
VITAE_CONF_PATH="/root/.vitae/vitae.conf"
NODEIP=$(curl -s4 icanhazip.com)
COIN_PORT=8765
MASTERNODE_PRIVATE_KEY="$1"

function update_config() {
 RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
 RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $VITAE_CONF_PATH
rpcuser=$RPC_USERNAME
rpcpassword=$RPC_PASSWORD
logintimestamps=1
maxconnections=64
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$MASTERNODE_PRIVATE_KEY
EOF
}
update_config
vitaed -daemon
