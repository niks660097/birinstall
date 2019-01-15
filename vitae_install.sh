#!/bin/bash
sudo apt-get install wget
wget https://github.com/VitaeTeam/Vitae/releases/download/4.3.0/vitae-4.3.0-linux-64.tar.gz"
tar -xf vitae-4.3.0-linux-64.tar.gz
cd vitae-4.3.0-linux-64
mv vitae-cli /usr/local/bin/
mv vitaed /usr/local/bin/
mv vitae-tx /usr/local/bin/
