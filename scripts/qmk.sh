#!/usr/bin/env sh

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"
valid=("mac")
check_os_compatibility "obsidian" "$OS" $valid
log_start "Configuring QMK"

qmk setup -y --home ~/.config/qmk_firmware

FROM_DIR="$CONFIG_DIR/qmk/lily58/keymaps/ajclarkson"
TARGET_DIR=~/.config/qmk_firmware/keyboards/lily58/keymaps
symlink_dir "$FROM_DIR" "$TARGET_DIR"

FROM_DIR="$CONFIG_DIR/qmk/plaid/keymaps/ajclarkson"
TARGET_DIR=~/.config/qmk_firmware/keyboards/dm9records/plaid/keymaps
symlink_dir "$FROM_DIR" "$TARGET_DIR"



log_success "Configured QMK"
