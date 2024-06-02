#!/bin/bash

sudo apt install -y default-jdk

### Setup JDK ###
echo -e "${CYAN}### Setting up JDK and java ENVs ###"
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
sudo printf "\nexport JAVA_HOME=\"%s\"\n" $JAVA_HOME_PATH | tee -a /etc/profile
sudo printf "export PATH=\$JAVA_HOME/bin:\$PATH\n" | tee -a /etc/profile

