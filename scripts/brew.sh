#!/usr/bin/env sh
ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_section_start "Installing brew and common programs"

brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew_install_or_upgrade zsh

# Set zsh as the default shell
if [ $SHELL = "/bin/zsh" ]; then
    echo "Shell is already set to zsh"
else
    echo "Setting default shell to zsh"
    chsh -s /bin/zsh
fi

brew_install_or_upgrade nvm