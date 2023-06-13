#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"

source "$ROOT_DIR/commands/__util.sh"

log_start "Configuring nvim"

if [ -d ~/.config/nvim ]; then
  echo "Cleaning up ~/.config/nvim/"
  rm -rf ~/.config/nvim/
fi

mkdir -p ~/.config/nvim
FROM_DIR="$CONFIG_DIR/nvim"
TARGET_DIR=~/.config/nvim
symlink_files "$FROM_DIR/*" "$TARGET_DIR"

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

log_success "Successfully configured nvim"


