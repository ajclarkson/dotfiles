#!/usr/bin/env sh

ROOT_DIR=$1
SETUP_MODE=$2
CONFIG_DIR=$ROOT_DIR/config
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing applications via cask"

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-caskaydia-cove-nerd-font


for app in "raycast" \
  "bartender" \
  "logitune" \
  "whatsapp" \
  "appcleaner" \
  "rectangle" \
  "google-chrome" \
  "1password" \
  "zwift" \
  "visual-studio-code" \
  "spotify" \
  "obsidian" \
  "iterm2"; do
  brew install --cask $app
done

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$CONFIG_DIR/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

cat $CONFIG_DIR/vscode/extensions.txt | while read ext; do
    code --install-extension $ext
done 
symlink $CONFIG_DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

if [ $SETUP_MODE == "work" ]; then
  for work_app in "slack" \
    "meetingbar"; do
    brew install --cask $work_app
  done

fi

if [ $SETUP_MODE == "home" ]; then
    for home_app in "lens" \
    "mqttx" \
    "nordvpn" \
    "qmk-toolbox" \
    "openvpn-connect" \
    "arq" \
    "docker" \
    "steam" \
    "balenaetcher" \
    "vlc"; do
    brew install --cask $home_app
    done
fi

log_success "Succesfully installed applications via cask"
log_warn "Some applications only pull an installer, check the log outputs to see if further action should be taken"