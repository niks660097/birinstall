#!/bin/bash
wget https://github.com/snodeco/snode-coin/releases/download/v3.0.1/snodecoin-3.0.1-linux64.tar.gz
tar -xf snodecoin-3.0.1-linux64.tar.gz
cd ./snodecoin-3.0.1/bin
mv snodecoin-cli /usr/local/bin
mv snodecoind /usr/local/bin
mv snodecoin-tx /usr/local/bin
