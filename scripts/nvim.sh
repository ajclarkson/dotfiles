#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
OS=$3
ARCH=$4
source "$ROOT_DIR/commands/__util.sh"


log_start "Installing and Configuring nvim"

if [ $OS = "linux" ]; then
    sudo apt-get install -y ninja-build gettext cmake unzip
    mkdir -p ~/applications && pushd ~/applications
    sudo apt-get install ninja-build gettext cmake unzip
    git clone https://github.com/neovim/neovim
    cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb   
elif [ $OS = "mac" ]; then
    brew install neovim
else
    log_error "Platform $OS is not supported for neovim installation"
    exit 1
fi

FROM_DIR="$CONFIG_DIR/nvim"
TARGET_DIR=~/.config/nvim
symlink_dir "$FROM_DIR" "$TARGET_DIR"

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

log_success "Successfully configured nvim"
