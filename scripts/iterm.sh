#!/usr/bin/env sh

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"

if [ $OS != "mac" ]; then
    log_warn "iTerm is only installed on macs, detected $OS"
    exit 0
fi

log_start "Installing and configuring iTerm"

brew install --cask iterm2

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$CONFIG_DIR/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

log_success "iTerm installed and configured"


