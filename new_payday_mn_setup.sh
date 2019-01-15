#!/bin/bash

ARCH=`lscpu | head -n 1 | awk -F ":" '{print $2}' | tr -d '[:space:]'`
SUDO=`which sudo`
USER=`whoami`
UNZIP=`which unzip`
DIR=$PWD
USER_UID=`id -u $USER`
USER_GID=`id -g $USER`

echo "================================================================="
echo "=== Running Setup Script for Install and Configure PayDayCoin: ==="
echo "=== 1. installing PayDayCoin Daemon"
echo "=== 2. configure Basic PayDayCoin Node"
echo "=== 3. configure Cron Jobs"
if [ "$1" == "masternode" ]; then
echo "=== 4. configure Masternode PayDayCoin Node"
fi
echo "================================================================="
#read -p "Are you sure to continue? (yes/no) " answer
#if [ "$answer" == "yes" ]; then
#	echo "Wait while installing and configuring PayDayCoin Node"
#else
#	echo "Exit from scripts"
#	exit
#fi

. <(curl -sL https://raw.githubusercontent.com/PayDayCoinIo/Binaries/master/scripts/utils)

config_basic()
{

echo "Initial Basic PayDay daemon config"

PID=$(pidof pdd 2>&1)
if [ "$PID" != "" ]; then
pdd stop > /dev/null 2>&1
wait_pdd_stops
fi

$CMD_SUDO mkdir -p $HOME/.PayDay/
$CMD_SUDO chown -R $USER_UID:$USER_GID $HOME/.PayDay/
echo -en "rpcuser=PayDayrpc\nrpcpassword=" > $HOME/.PayDay/PayDay.conf && echo microtime | md5sum | base64 >> $HOME/.PayDay/PayDay.conf
echo "server=1" >> $HOME/.PayDay/PayDay.conf
echo "daemon=1" >> $HOME/.PayDay/PayDay.conf
$CMD_SUDO chown -R $USER_UID:$USER_GID $HOME/.PayDay/

crontab -l | grep -v "pdd" > /tmp/pdd.cron
echo "@reboot pdd -daemon" >> /tmp/pdd.cron
echo "*/5 * * * *  pdd_sure_run" >> /tmp/pdd.cron
crontab /tmp/pdd.cron
rm -f /tmp/pdd.cron

}

config_masternode()
{

echo "Initial Masternode Configuration"

PID=$(pidof pdd 2>&1)
if [ "$PID" == "" ]; then
pdd > /dev/null 2>&1
wait_pdd_starts
fi

node=`pdd getaddressesbyaccount "" |  grep -oe "[0-9a-zA-Z]*"`
echo Masternode address $node > $HOME/masternode_info.txt
key=`pdd masternode genkey`
pk=`pdd dumpprivkey $node`

echo "Stopping daemon"

pdd stop > /dev/null 2>&1
sleep 1
wait_pdd_stops

echo "Configuring masternode"

CONF=$(cat $HOME/.PayDay/PayDay.conf | grep -v "masternode")
echo "" > $HOME/.PayDay/PayDay.conf
for param in $CONF
do
echo $param >> $HOME/.PayDay/PayDay.conf
done

echo Masternode key $key >> $HOME/masternode_info.txt
echo masternodeprivkey=$key >> $HOME/.PayDay/PayDay.conf
echo masternode=1 >> $HOME/.PayDay/PayDay.conf
echo masternodesoftlock=1 >> $HOME/.PayDay/PayDay.conf

echo "Starting daemon"

echo Masternode wallet private key $pk >> $HOME/masternode_info.txt
echo Your masternode data stored in $HOME/masternode.info.txt
cat $HOME/masternode_info.txt

}

check_root()
{

if [ "$SUDO" == "" ]; then
	echo "To run the script and install PayDayCoin, you need to be installed sudo."
	return 0
else
	return 1
fi

}

if [ "$USER" != "root" ]; then
check_root
	if [ "$?" -eq "1" ]; then
		CMD_SUDO='sudo'
	else
		exit
	fi
else
	CMD_SUDO=''
fi

$CMD_SUDO rm -f /tmp/payday.zip

echo "Configure system language environment.."

EN_LANG=`$CMD_SUDO cat /etc/locale.gen | grep -o "^\s*en_US.UTF-8.*"`

if [ -z "$LANG" ]; then
        if [ -z "$EN_LANG" ]; then
                $CMD_SUDO echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
        fi
        $CMD_SUDO locale-gen
        $CMD_SUDO update-locale LANG=en_US.UTF-8
else

        CUR_LANG=`$CMD_SUDO cat /etc/locale.gen | grep -o "^\s*$LANG.*"`
        CUR_ENC=`$CMD_SUDO echo "$LANG" | cut -d. -f2`

        if [ -z "$CUR_LANG" ]; then
                $CMD_SUDO echo "$LANG" "$CUR_ENC" >> /etc/locale.gen
        fi
        $CMD_SUDO locale-gen
        $CMD_SUDO update-locale LANG=$LANG
fi

if [ "$ARCH" = "x86_64" ]; then
	curl -L https://github.com/PayDayCoinIo/Binaries/raw/master/PayDayCoinDaemonLinux_x64.zip -o /tmp/payday.zip
else
	curl -L https://github.com/PayDayCoinIo/Binaries/raw/master/PayDayCoinDaemonLinux_x86.zip -o /tmp/payday.zip
fi
FILE=/tmp/payday.zip

if [ "$UNZIP" == "" ]; then
	echo "installing unzip.."
	$CMD_SUDO apt-get -y install unzip > /dev/null 2>&1
	UNZIP=`which unzip`
fi

cd /tmp/

$UNZIP -o $FILE > /dev/null 2>&1

$CMD_SUDO rm -f /usr/bin/pdd
$CMD_SUDO rm -f /tmp/payday.zip
$CMD_SUDO rm -f /usr/local/bin/pdd
$CMD_SUDO rm -f /usr/local/bin/pdd_sure_run
$CMD_SUDO cp /tmp/pdd /usr/local/bin/pdd
$CMD_SUDO chmod a+x /usr/local/bin/pdd
$CMD_SUDO ln -s /usr/local/bin/pdd /usr/bin/pdd
$CMD_SUDO curl -sL https://raw.githubusercontent.com/PayDayCoinIo/Binaries/master/scripts/pdd_sure_run -o /usr/local/bin/pdd_sure_run
$CMD_SUDO chmod +x /usr/local/bin/pdd_sure_run
$CMD_SUDO mkdir -p /usr/local/lib/pdd/
$CMD_SUDO curl -sL https://raw.githubusercontent.com/PayDayCoinIo/Binaries/master/scripts/utils -o /usr/local/lib/pdd/utils
$CMD_SUDO chmod +x /usr/local/lib/pdd/utils

$CMD_SUDO rm /tmp/pdd

if [ "$1" = "masternode" ]; then
	if [ ! -f "$HOME/.PayDay/PayDay.conf" ]; then
		config_basic
		sleep 1
	fi
	config_masternode
else
	config_basic
	echo "If you want to configure Masternode, run this script again: ./linux_install masternode"
fi

pdd_sure_run

echo "PayDayCoin Node successfull installing. To run - print command: pdd "
