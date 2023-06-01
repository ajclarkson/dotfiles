#!/usr/bin/env sh
ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_section_start "Installing applications via cask"

brew install --cask spotify
brew install --cask obsidian
brew install --cask iterm2
brew install --cask raycast
brew install --cask bartender
brew install --cask logitune
brew install --cask whatsapp

# work apps
brew install --cask slack
brew install --cask meetingbar