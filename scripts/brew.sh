#!/usr/bin/env sh
ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing brew and common programs"

brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

for app in "fish" \
  "fisher" \
  "fd" \
  "fzf" \
  "neovim" \
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

# Set fish as the default shell
if [ $SHELL = "/opt/homebrew/bin/fish" ]; then
    echo "Shell is already set to fish"
else
    echo "Setting default shell to fish"
    sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
    chsh -s /opt/homebrew/bin/fish
fi

log_success "Successfully installed brew and common programs"