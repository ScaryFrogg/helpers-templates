#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "$SCRIPT_DIR/../setup.settings"

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
