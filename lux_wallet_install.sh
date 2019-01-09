#!/bin/bash

wget https://github.com/LUX-Core/lux/archive/v5.2.3.tar.gz
mkdir -p lux && tar xf tarfilename -C ./lux --strip-components=1
sudo find lux/ -type f -iname "*.sh" -exec chmod +x {} \;
cd lux/
sudo sh ./depends/install-dependencies.sh
sudo ./autogen.sh && sudo ./configure --disable-tests --without-gui && sudo make clean && sudo make -j$(nproc)
cd $HOME
mkdir ~/.lux
