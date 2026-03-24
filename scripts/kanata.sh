#!/usr/bin/sh

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"
valid=("mac")
check_os_compatibility "kanata" "$OS" $valid

log_start "Configuring kanata"

FROM_DIR="$CONFIG_DIR/kanata"
TARGET_DIR=~/.config/kanata
mkdir -p $TARGET_DIR
symlink_files "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured Kanata"
