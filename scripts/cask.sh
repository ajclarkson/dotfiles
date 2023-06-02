#!/usr/bin/env sh

ROOT_DIR=$1
SETUP_MODE=$2
CONFIG_DIR=$ROOT_DIR/config
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing applications via cask"

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-caskaydia-cove-nerd-font

brew install --cask spotify
brew install --cask obsidian
brew install --cask iterm2
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$CONFIG_DIR/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

brew install --cask raycast
brew install --cask bartender
brew install --cask logitune
brew install --cask whatsapp
brew install --cask appcleaner
brew install --cask rectangle
brew install --cask google-chrome
brew install --cask 1password
brew install --cask zwift

brew install --cask visual-studio-code
cat $CONFIG_DIR/vscode/extensions.txt | while read ext; do
    code --install-extension $ext
done 
symlink $CONFIG_DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

if [ $SETUP_MODE == "work" ]; then
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

log_success "Succesfully installed applications via cask"
log_warn "Some applications only pull an installer, check the log outputs to see if further action should be taken"