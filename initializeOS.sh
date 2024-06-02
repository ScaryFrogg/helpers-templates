#!/bin/bash
### Notes
#Put all .deb installers inisde ./installers folder 
# and all zipped(.tar and .tar.gz) portable software inside ./portable folder
#Update Variables if needed
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "I ${RED}love${NC} Stack Overflow"iables ###
GIT_USER_NAME="Vojin Puric"
GIT_USER_EMAIL="puricvojin@gmail.com"

### General ###
echo "sudo needed for some of configuration"
sudo echo "Super User granted"
sudo apt update
sudo apt upgrade -y
#install apt packages
sudo apt install -y default-jdk
sudo apt install -y build-essential
sudo apt install -y curl
sudo apt install -y wget
sudo apt install -y htop
sudo apt install -y alacritty
sudo apt install -y ktorrent

### move scripts to bin ###
echo -e "${CYAN}Moving scripts to /usr/local/bin"
sudo cp -a ./bin/. /usr/local/bin/

### Setup Git ###
echo -e "${CYAN}### Setting up git ###"
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL
git config --list --global

### Setup JDK ###
echo -e "${CYAN}### Setting up JDK and java ENVs ###"
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
sudo printf "\nexport JAVA_HOME=\"%s\"\n" $JAVA_HOME_PATH | tee -a /etc/profile
sudo printf "export PATH=\$JAVA_HOME/bin:\$PATH\n" | tee -a /etc/profile

### Setup PATH ###
sudo printf "export PATH=\$PATH:/usr/sbin\n" | tee -a /etc/profile

### Setup Node ###
echo -e "${CYAN}### Setting up Node.js and npm ###"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# download and install Node.js
nvm install 20
echo -e "${CYAN} Node version $(node -v)"
echo -e "${CYAN} npm version $(npm -v)"

### Run offline installers ###
echo -e "${CYAN}### Running Offline Installers ###"
if [ -d "./installers" ]; 
then
    for file in ./installers/*
    do
        echo "### Installing $file"
        sudo dpkg -i "$file"
    done
fi

### Extracting portable software ###
echo -e "${CYAN}### Extracting Portable Software to HOME ###"
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
        tar xvzf $file -C ~ || echo "extracting $file failed" > /dev/stderr
    done
    
fi

### Configure Kotlin ###
#echo "### Configuring Kotlin ###"

#sudo printf "\nexport KOTLIN_HOME=\"/home/vojin/idea-IU-221.5787.30/plugins/Kotlin\"\n" | tee -a /etc/profile
#sudo printf "export PATH=\$PATH:\$KOTLIN_HOME/bin\n" | tee -a /etc/profile

### Install Vue ###
echo -e "${CYAN}### Installing Vue.js ###"
sudo npm install -g @vue/cli

# TODO ### Setup nvim ###
echo -e "${CYAN}### Installing NeoVim ###"
###sudo apt install neovim ###

### Terminal color-schemes ###
echo -e "${CYAN}### Setting up Terminal color-schemes ###"
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


### Fix if some installs were broken ###
sudo apt --fix-broken install -y
sudo apt autoremove -y
