#!/usr/bin/env sh
set -e

SETUP_MODE=${1:-"default"}
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles (mode: $SETUP_MODE)"

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# CLI tools
brew install stow git fish fnm neovim tmux tmuxinator bat ripgrep fzf eza curl jq wget coreutils fd

# Core apps
brew install --cask \
  alacritty \
  font-hack-nerd-font \
  font-fira-code \
  font-caskaydia-cove-nerd-font \
  raycast \
  bartender \
  logitune \
  whatsapp \
  appcleaner \
  rectangle \
  google-chrome \
  1password \
  zwift \
  spotify \
  qmk-toolbox

if [ "$SETUP_MODE" = "work" ]; then
  brew install --cask slack meetingbar
elif [ "$SETUP_MODE" = "home" ]; then
  brew install --cask mqttx nordvpn openvpn-connect arq docker steam balenaetcher vlc sonos 1password-cli
fi

# Stow common packages
cd "$DOTFILES_DIR"
stow alacritty bat fish nvim tmux tmuxinator git

# Stow environment packages
if [ "$SETUP_MODE" = "work" ]; then
  stow git-work
elif [ "$SETUP_MODE" = "home" ]; then
  stow qmk
fi

# Node
fnm install --lts
fnm default lts-latest
fnm use lts-latest
npm i -g npm

# Fish as default shell
FISH_PATH=/usr/local/bin/fish
if [ "$(uname -m)" = "arm64" ]; then
  FISH_PATH=/opt/homebrew/bin/fish
fi

if [ "$SHELL" != "$FISH_PATH" ]; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells
  chsh -s "$FISH_PATH"
fi

# Fisher
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Done! Run ./macos.sh to apply system defaults, then restart your shell."
