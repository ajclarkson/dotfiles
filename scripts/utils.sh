#!/usr/bin/env sh

ROOT_DIR=$1
SETUP_MODE=$2
CONFIG_DIR=$ROOT_DIR/config
OS=$3
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing common tools and utilities for $OS"

core_utils="ripgrep fzf exa curl jq bat wget"
mac_utils="coreutils mas wifi-password terraform fd qmk/qmk/qmk"

if [ $OS == "linux" ]; then
    sudo apt-get install -y $core_utils
elif [ $OS == "mac" ]; then
    brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install $core_utils $mac_utils
else
    log_error "Platform $OS is incompatible with the utils setup script"
    exit 1
fi

