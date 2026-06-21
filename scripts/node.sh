#!/usr/bin/env sh

ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing fnm and latest LTS version of node"

brew install fnm

fnm install --lts
fnm default lts-latest
fnm use lts-latest

echo "Updating npm"
npm i -g npm

log_success "fnm and node installed successfully"
