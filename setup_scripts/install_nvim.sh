!#/bin/bash
# prerequisits
sudo apt install make gcc ripgrep unzip git xclip curl

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
#sudo printf "export PATH=\$PATH:/opt/nvim-linux64/bin\n" >> ~/.bashrc

sudo printf "set -o vi\n" >> ~/.bashrc
rm -rf ./nvim-linux64.tar.gz

#add kickstart config
mkdir -p ~/.config/nvim/
git clone git@github.com:ScaryFrogg/kickstart.nvim.git ~/.config/nvim/
