#!/bin/bash
sudo apt-get install unzip
sudo apt-get install wget
wget https://github.com/exclfork/ExclusiveCoin/releases/download/v1400/exclusivecoind-ubu14-v1400.zip
unzip exclusivecoind-ubu14-v1400.zip
mv exclusivecoind /usr/local/bin
