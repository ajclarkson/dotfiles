#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"
valid=("mac")
check_os_compatibility "kitty" "$OS" $valid
log_start "Installing and configuring kitty"

brew install kitty

FROM_DIR="$CONFIG_DIR/kitty"
TARGET_DIR=~/.config/kitty
symlink_dir "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured kitty"

