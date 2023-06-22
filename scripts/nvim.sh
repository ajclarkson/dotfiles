#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

source "$ROOT_DIR/commands/__util.sh"

log_start "Configuring nvim"

FROM_DIR="$CONFIG_DIR/nvim"
TARGET_DIR=~/.config/nvim
symlink_dir "$FROM_DIR" "$TARGET_DIR"

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

log_success "Successfully configured nvim"
