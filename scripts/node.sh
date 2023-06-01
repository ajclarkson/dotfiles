#!/usr/bin/env sh

ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_section_start "Configuring node to latest stable version"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install stable
nvm alias default stable
nvm use stable

source $(brew --prefix nvm)/nvm.sh

echo "Updating npm"
npm i -g npm