#!/bin/bash

### General ###
sudo apt update
sudo apt upgrade
# gdebi for installing packages
sudo apt install -yy gdebi

### move scripts to bin ###
echo "Moving scripts to /usr/local/bin"
sudo cp -a ./bin/. /usr/local/bin/

### Setup Git ###
echo "### Setting up git ###"
git config --global user.name "Vojin Puric"
git config --global user.email puricvojin@gmail.com
git config --list --global

### Setup JDK ###
echo "### Setting up JDK ###"
sudo apt install --yy openjdk-11-jdk
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which javac)))) || echo "Couldn't find Java"
sudo printf "\nexport JAVA_HOME=\"%s\"\n" $JAVA_HOME_PATH | tee -a /etc/profile
sudo printf "export PATH=\$JAVA_HOME/bin:\$PATH\n" | tee -a /etc/profile
sudo source /etc/profile

# TODO ### Setup fish ###

### Run offline installers ###
echo "### Running Offline Installers ###"
if [ -d "./installers" ]; 
then
    for file in ./installers/*
    do
        echo "### Installing $file"
        sudo dpkg -i "$file"
    done
fi

### Extracting portable software ###
if [ -d "./portable" ]; 
then
    for file in ./portable/*.tar
    do
        echo "### Extracting $file to HOME"
        tar xvf $file -C ~ || echo "extracting $file failed" > /dev/stderr
    done
    for file in ./portable/*.tar.gz
    do
        echo "### Extracting $file to HOME"
        ar xvzf $file -C ~ || echo "extracting $file failed" > /dev/stderr
    done
    
fi

# TODO ### Setup VS Code ###