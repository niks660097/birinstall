#!/bin/bash
echo 'stopping and starting birakecoin'
birakecoin-cli stop
sleep 5
birakecoind -daemon
echo 'stopping and starting darkpaycoin'
darkpaycoin-cli stop
sleep 5
darkpaycoind -daemon
echo 'stopping and starting Paydaycoin'
pdd stop
sleep 5
pdd -daemon
echo 'stopping and starting vitae'
vitae-cli stop
sleep 5
vitaed & 
echo 'stopping and starting safeinsure'
safeinsure-cli stop
sleep 5
safeinsured -daemon
echo 'stopping and starting exclusivecoin'
exclusivecoind stop
sleep 5
exclusivecoind -daemon
echo 'stopping and starting logiscoin'
logiscoin-cli stop
sleep 5
logiscoind -daemon
echo 'stopping and starting snodecoin'
snodecoin-cli stop
sleep 5
snodecoind -daemon
echo 'stopping and starting bitcoingreen'
bitcoingreen-cli stop
sleep 5
bitcoingreend -daemon
echo 'stopping and starting luxcoin'
lux-cli stop
sleep 10
luxd -daemon
echo 'stopping and starting midascoin'
midas-cli stop
sleep 5
midasd -daemon
echo 'stopping and starting energi'
energi-cli stop
sleep 5
energid -daemon
echo 'stopping and starting goldpoker'
gpkr-cli stop
sleep 5
gpkrd -daemon
echo 'stopping and starting skyhub'
skyhub-cli stop
sleep 5
skyhubd -daemon
echo 'start daemons end'





