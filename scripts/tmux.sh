#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing and Configuring tmux"

if [ $OS = "mac" ]; then
    brew install tmux
elif [ $OS = "linux" ]; then
    sudo apt-get install -y tmux
else
    log_error "Platform $OS is incompatible with tmux install script"
    exit 1
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

FROM_DIR="$CONFIG_DIR/tmux"
TARGET_DIR=~/.config/tmux
symlink_dir "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured tmux"
