#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
source "$ROOT_DIR/commands/__util.sh"

log_start "Configuring git"

FROM_DIR="$CONFIG_DIR/git"
TARGET_DIR=~/
symlink_files "$FROM_DIR" "$TARGET_DIR"
log_success "Configured git successfully"
