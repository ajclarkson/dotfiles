#!/usr/bin/env sh
ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing brew and common programs"

brew -v >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

for app in "zsh" \
  "nvm" \
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

# Set zsh as the default shell
if [ $SHELL = "/bin/zsh" ]; then
    echo "Shell is already set to zsh"
else
    echo "Setting default shell to zsh"
    chsh -s /bin/zsh
fi

log_success "Successfully installed brew and common programs"