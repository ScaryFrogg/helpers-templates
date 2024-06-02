curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
printf "export PATH=\$PATH:/opt/nvim-linux64/bin\n" >> ~/.bashrc
rm -rf ./nvim-linux64.tar.gz
