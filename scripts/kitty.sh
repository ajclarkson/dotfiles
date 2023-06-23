#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
source "$ROOT_DIR/commands/__util.sh"

if [ $OS != "mac" ]; then
    log_warn "Platform $OS is incompatible with kitty configuration script"
    exit 0
fi

log_start "Installing and configuring kitty"

brew install kitty

FROM_DIR="$CONFIG_DIR/kitty"
TARGET_DIR=~/.config/kitty
symlink_dir "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured kitty"

