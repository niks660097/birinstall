# Goto bin directory 
cd /usr/local/bin

# Download the daemon (and rename it)
wget -O exclusivecoind https://github.com/exclfork/ExclusiveCoin/releases/download/v1.2.0.0-daemon/exclusivecoind-ubuntu-v1200

# Add read/execute rights, only for the owner of the file.
chmod 500 exclusivecoind
exclusivecoind -deamon
CONFIGFOLDER=/root/.exclusivecoin
CONFIG_FILE=exclusivecoin.conf
NODEIP=$(curl -s4 icanhazip.com)
PRIVATE_KEY="$1"
PORT=23230

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
externalip=$NODEIP
masternode=1
masternodeprivkey=$PRIVATE_KEY
masternodeaddr=$NODEIP:$PORT
staking=0
bind=$NODEIP
EOF
}
create_config()
