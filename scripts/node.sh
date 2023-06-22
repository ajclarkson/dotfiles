#!/usr/bin/env sh

ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing nvm and latest stable version of node"

fish -c "nvm install lts"
fish -c "nvm alias default lts"
fish -c "nvm use lts"

echo "Updating npm"
npm i -g npm

log_success "nvm and node installed successfully"
