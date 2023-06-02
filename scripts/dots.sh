#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

source "$ROOT_DIR/commands/__util.sh"

log_start "Symlinking dotfiles from $CONFIG_DIR/home/ to home directory"

FROM_FILES="$CONFIG_DIR/home/.*"
TARGET_DIR=~

symlink_files "$FROM_FILES" "$TARGET_DIR"

log_success "Symlinked dotfiles to home directory successfully"