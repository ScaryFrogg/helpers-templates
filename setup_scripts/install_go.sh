#!/bin/bash

curl -OL https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz
sudo printf "export PATH=$PATH:/usr/local/go/bin\n" >> ~/.bashrc
sudo rm go1.23.1.linux-amd64.tar.gz
go version
