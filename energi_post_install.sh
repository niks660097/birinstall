#!/bin/bash


CONFIGFOLDER="/root/.energicore"
COINFIG_FILE="energi.conf"
PRIVATE_KEY="$1"
NODEIP=$(curl -s4 icanhazip.com)

function create_config() {
  mkdir $CONFIGFOLDER >/dev/null 2>&1
#  RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
#  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $CONFIGFOLDER/$CONFIG_FILE
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcallowip=127.0.0.1
listen=1
server=1
daemon=1
maxconnections=24
externalip=$NODEIP
masternode=1
masternodeprivkey=$PRIVATE_KEY
$BIND
EOF
}
