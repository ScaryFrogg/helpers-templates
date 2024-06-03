#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
source "$SCRIPT_DIR/../setup.settings"

echo -e "${CYAN} Generating SSH keys${NC}"
if [ -z "$SSH_PASSPHRASE" ]; then
  ssh-keygen -t ed25519 -q -N "" -f ~/.ssh/id_ed25519
else
  ssh-keygen -t ed25519 -q -N "$SSH_PASSPHRASE" -f ~/.ssh/id_ed25519
fi
ssh-add ~/.ssh/id_ed25519
