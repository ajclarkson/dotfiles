#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

source "$ROOT_DIR/commands/__util.sh"

log_start "Configuring Fish"

if [ -d ~/.config/fish ]; then
  echo "Cleaning up ~/.config/fish/"
  rm -rf ~/.config/fish/
fi

mkdir -p ~/.config/fish
FROM_DIR="$CONFIG_DIR/fish"
TARGET_DIR=~/.config/fish
symlink_files "$FROM_DIR/*" "$TARGET_DIR"

fisher install PatrickF1/fzf.fish
fisher install jorgebucaran/nvm.fish

log_success "Successfully configured fish"


