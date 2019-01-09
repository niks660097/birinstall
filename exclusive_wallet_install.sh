#!/bin/bash

git clone https://github.com/exclusivecoin/Exclusive.git
cd ExclusiveCoin/src
sudo apt-get install libssl-dev
sudo apt-get install libboost-dev
sudo apt-get install libdb++-dev
sudo make -f makefile.unix
