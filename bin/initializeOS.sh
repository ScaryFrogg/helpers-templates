#!/bin/bash
### Notes
#Put all .deb installers inisde ./installers folder 
# and all zipped(.tar and .tar.gz) portable software inside ./portable folder
#Update Variables if needed

### Variables ###
GIT_USER_NAME="Vojin Puric"
GIT_USER_EMAIL="puricvojin@gmail.com"

### General ###
sudo apt update
sudo apt upgrade
#install apt packages
sudo apt install -y openjdk-11-jdk htop

### move scripts to bin ###
echo "Moving scripts to /usr/local/bin"
sudo cp -a ./bin/. /usr/local/bin/

### Setup Git ###
echo "### Setting up git ###"
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL
git config --list --global

### Setup JDK ###
echo "### Setting up JDK ###"
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
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
echo "### Extracting Portable Software to HOME ###"
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

### Terminal color-schemes ###
echo "### Setting up Terminal color-schemes ###"
cd ~
git clone https://gitlab.com/dwt1/shell-color-scripts.git
sudo cp ./shell-color-scripts/colorscript.sh /usr/bin/colorscript
#remove unwanted and move rest to /opt/
rm ./shell-color-scripts/colorscripts/xmonad
rm ./shell-color-scripts/colorscripts/spectrum
rm ./shell-color-scripts/colorscripts/doom-original
rm ./shell-color-scripts/colorscripts/guns
rm ./shell-color-scripts/colorscripts/colortest-slim
sudo mv shell-color-scripts/ /opt/
#add to run on every terminal launch
sudo echo -e "\ncolorscript -r\n" >> ~/.bashrc