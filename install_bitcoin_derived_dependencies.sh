sudo apt-get update
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libtool libevent-dev bsdmainutils python3
sudo apt-get install automake
sudo apt-get install libdb++-dev
sudo apt-get install build-essential autotools-dev
sudo apt-get install autoconf pkg-config libssl-dev
sudo apt-get install libboost-all-dev
sudo apt-get install libminiupnpc-dev
sudo apt-get install git
sudo apt-get install software-properties-common
sudo apt-get install python-software-properties
sudo apt-get install g++
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
sudo apt-get install libzmq3-dev
sudo apt-get install libprotobuf-dev protobuf-compiler libqrencode-dev
sudo apt-get install unzip
sudo apt-get install wget
sudo apt-get install tar

wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar -xvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix
mkdir -p build
BDB_PREFIX=$(pwd)/build
../dist/configure --disable-shared --enable-cxx --with-pic --prefix=$BDB_PREFIX
sudo make install
cd ../..
