#!/usr/bin/env sh
ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"
SETUP_MODE=$2
OS=$3
ARCH=$4

if [ $OS != "mac" ]; then
    log_warn "Brew commands only run on mac, detected $OS"
    exit 0
fi

log_start "Installing brew and common programs"

brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

for app in "fish" \
  "fd" \
  "ripgrep" \
  "tmux" \
  "fzf" \
  "coreutils" \
  "exa" \
  "curl" \
  "jq" \
  "bat" \
  "terraform" \
  "wget" \
  "mas" \
  "wifi-password"; do
  brew_install_or_upgrade $app
done

log_success "Successfully installed brew and common programs"
