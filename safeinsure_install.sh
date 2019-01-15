#!/bin/bash
wget https://latest.safeinsure.io/safeinsure-x86_64-linux-gnu.tar.gz
tar -xf safeinsure-x86_64-linux-gnu.tar.gz
cd SafeInsure-1.0.0
mv safeinsure-cli /usr/local/bin
mv safeinsured /usr/local/bin
mv safeinsure-tx /usr/local/bin
