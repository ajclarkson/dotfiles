#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"
valid=("mac")
check_os_compatibility "alacritty" "$OS" $valid
log_start "Installing and configuring alacritty"

brew install alacritty

FROM_DIR="$CONFIG_DIR/alacritty"
TARGET_DIR=~/.config/alacritty
symlink_dir "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured alacritty"

