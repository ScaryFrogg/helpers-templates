#!/bin/bash
source setup.settings

main() {
    #perform update
    sudo apt update
    sudo apt upgrade -y
    #install importaint apt packages
    sudo apt install -y build-essential
    sudo apt install -y curl
    sudo apt install -y wget

    sudo apt install -y htop
    sudo apt install -y alacritty
    sudo apt install -y ktorrent

    script_install "install_jdk"
    script_install "install_node"
    script_install "install_utility_apts"
    script_install "install_nvim"

    ### Setup PATH ###
    sudo printf "export PATH=\$PATH:/usr/sbin\n" | tee -a /etc/profile
}

function script_install() {
    local var_name="$1"
    local var_value="${!var_name}"

    if [ "$var_value" = true ]; then
        bash "./setup_scripts/${var_name}.sh"
    fi
}

main
