#!/usr/bin/sh

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$OS
source "$ROOT_DIR/commands/__util.sh"

if [ $OS != "mac" ]; then
    log_warn "Platform $OS is incompatible with Obsidian setup script"
    exit 0
fi
log_start "Configuring obsidian"

FROM_DIR="$CONFIG_DIR/obsidian"
TARGET_DIR=~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Second\ Brain/
symlink_files "$FROM_DIR" "$TARGET_DIR"

log_success "Successfully configured Obsidian"
