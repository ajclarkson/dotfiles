#!/usr/bin/env sh

ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Updating package managers and packages"

sudo softwareupdate -i -a
fnm install --lts --latest
brew update
brew upgrade

log_success "Update command completed successfully"
