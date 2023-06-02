#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

source "$ROOT_DIR/commands/__util.sh"

log_start "Installing oh-my-zsh"

if [ -d ~/.oh-my-zsh/ ]; then
  echo "Cleaning up ~/.oh-my-zsh/"
  rm -rf ~/.oh-my-zsh/
fi
RUNZSH=no KEEP_ZSHRC=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
FROM_DIR="$CONFIG_DIR/oh-my-zsh"
TARGET_DIR=~/.oh-my-zsh/custom/
symlink_files "$FROM_DIR/*" "$TARGET_DIR"
rm ~/.zshrc

log_success "Successfully installed and configured oh-my-zsh"
