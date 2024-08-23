#!/usr/bin/env sh

ROOT_DIR=$1
SETUP_MODE=$2
CONFIG_DIR=$ROOT_DIR/config
OS=$3
ARCH=$4
source "$ROOT_DIR/commands/__util.sh"
valid=("mac")
check_os_compatibility "applications" "$OS" $valid
log_start "Installing common applications"

taps="homebrew/cask-fonts"
core_apps="\
    font-hack-nerd-font \
    font-fira-code \
    font-caskaydia-cove-nerd-font \
    raycast \
    bartender \
    logitune \
    whatsapp \
    appcleaner \
    rectangle \
    google-chrome \
    1password \
    zwift \
    spotify \
    obsidian \
    qmk-toolbox \
"

work_apps="\
    slack \
    meetingbar \
"

home_apps="\
    mqttx \
    nordvpn \
    openvpn-connect \
    arq \
    docker \
    steam \
    balenaetcher \
    vlc \
    sonos \
"

brew tap $taps
brew install --cask $core_apps

if [ $SETUP_MODE = "work" ]; then
    brew install --cask $work_apps
elif [ $SETUP_MODE = "home" ]; then
    brew install --cask $home_apps
fi

log_success "Successfully installed applications"
log_warn "Some applications only pull an installer, check the log outputs to see if further action should be taken"

