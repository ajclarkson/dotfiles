#!/usr/bin/env sh

ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing nvm and latest stable version of node"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install stable
nvm alias default stable
nvm use stable

source $NVM_DIR/nvm.sh

echo "Updating npm"
npm i -g npm

log_success "nvm and node installed successfully"
