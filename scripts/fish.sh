#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
ARCH=$4
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing and Configuring Fish"

if [ $OS = "linux" ]; then
    sudo apt-get install -y fish
elif [ $OS = "mac" ]; then
    brew install fish
else
    log_error "Platform $OS is incompatible with fish install script"
    exit 1
fi

if [ -d ~/.config/fish ]; then
  echo "Cleaning up ~/.config/fish/"
  rm -rf ~/.config/fish/
fi

mkdir -p ~/.config/fish
FROM_DIR="$CONFIG_DIR/fish"
TARGET_DIR=~/.config/fish
symlink_files "$FROM_DIR/*" "$TARGET_DIR"

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install jorgebucaran/nvm.fish"


FISH_PATH=/usr/local/bin/fish

if [ $OS = "mac" ] && [ $ARCH = "arm64" ]; then
    FISH_PATH=/opt/homebrew/bin/fish
fi

if [ $SHELL = $FISH_PATH ]; then
    echo "Shell is already set to fish @$FISH_PATH"
else
    echo "Setting default shell to fish @ $FISH_PATH"
    sudo sh -c 'echo $FISH_PATH >> /etc/shells'
    chsh -s $FISH_PATH
fi



log_success "Successfully configured fish"



