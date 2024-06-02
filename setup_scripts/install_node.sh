#!/bin/bash

source ../setup.settings

echo -e "${CYAN}### Setting up Node.js and npm ###"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# download and install Node.js
nvm install 20
echo -e "${CYAN} Node version $(node -v)"
echo -e "${CYAN} npm version $(npm -v)"
