#!/usr/bin/env sh
ROOT_DIR=$1
SETUP_MODE=$2
source "$ROOT_DIR/commands/__util.sh"

log_section_start "Installing applications via cask"

brew install --cask spotify
brew install --cask obsidian
brew install --cask iterm2
brew install --cask raycast
brew install --cask bartender
brew install --cask logitune
brew install --cask whatsapp
brew install --cask appcleaner

if [ $SETUP_MODE != "home" ]; then
    brew install --cask slack
    brew install --cask meetingbar
fi