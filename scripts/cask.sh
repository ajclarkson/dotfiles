#!/usr/bin/env sh
ROOT_DIR=$1
SETUP_MODE=$2
source "$ROOT_DIR/commands/__util.sh"

log_section_start "Installing applications via cask"

echo "installing custom fonts"
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-caskaydia-cove-nerd-font

brew install --cask spotify
brew install --cask obsidian
brew install --cask iterm2
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

brew install --cask raycast
brew install --cask bartender
brew install --cask logitune
brew install --cask whatsapp
brew install --cask appcleaner

if [ $SETUP_MODE != "home" ]; then
    brew install --cask slack
    brew install --cask meetingbar
fi

if [ $SETUP_MODE == "home" ]; then
    brew install --cask lens
    brew install --cask mqttx
    brew install --cask nordvpn
    brew install --cask qmk-toolbox
    brew install --cask openvpn-connect
fi