#!/bin/bash

### General ###
sudo apt update
sudo apt upgrade
# gdebi for installing packages
sudo apt install -yy gdebi

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
# TODO ### Setup VS Code ###