#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

source "$ROOT_DIR/commands/__util.sh"

log_start "Configuring tmux"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

FROM_DIR="$CONFIG_DIR/tmux"
TARGET_DIR=~/.config/tmux
symlink_dir "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured tmux"
