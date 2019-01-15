#!/bin/bash
wget https://github.com/bitcoingreen/bitcoingreen/releases/download/v1.3.0/bitcoingreen-1.3.0-i686-pc-linux-gnu.tar.gz
tar -xf bitcoingreen-1.3.0-i686-pc-linux-gnu.tar.gz
cd ./bitcoingreen-1.3.0/bin
mv bitcoingreen-cli /usr/local/bin
mv bitcoingreend /usr/local/bin/
mv bitcoingreen-tx /usr/local/bin
