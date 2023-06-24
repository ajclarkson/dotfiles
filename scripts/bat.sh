#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
source "$ROOT_DIR/commands/__util.sh"
log_start "Configuring bat utility"

FROM_DIR="$CONFIG_DIR/bat"
TARGET_DIR=~/.config/bat
symlink_dir "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured bat"
