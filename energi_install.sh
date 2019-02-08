#!/bin/bash

# sudo apt-get install software-properties-common
# sudo add-apt-repository ppa:bitcoin/bitcoin
# sudo apt-get update
# sudo apt install libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libevent-pthreads-2.1-6 libminiupnpc10 libzmq5 libdb4.8 libdb4.8++
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi/v1.1.1/energi-v1.1.1-ubuntu-18.04LTS.tar.gz
tar -xvzf energi-v1.1.1-ubuntu-18.04LTS.tar.gz
cd ./energicore-1.1.0/bin
cp energi-cli /usr/local/bin
cp energid /usr/local/bin
cp energi-qt /usr/local/bin
# echo "export PATH=\${PATH}:$HOME/energi/bin" >> $HOME/.bashrc
