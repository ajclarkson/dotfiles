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
brew install stow git fish fnm neovim tmux tmuxinator bat ripgrep fzf eza curl jq wget coreutils fd tfenv tree-sitter

# Core apps
brew install --cask --adopt \
  ghostty \
  font-hack-nerd-font \
  font-fira-code \
  font-caskaydia-cove-nerd-font \
  raycast \
  bartender \
whatsapp \
  appcleaner \
  rectangle \
  google-chrome \
  1password \
  slack \
  claude-code

if [ "$SETUP_MODE" = "work" ]; then
  brew install --cask --adopt meetingbar
elif [ "$SETUP_MODE" = "home" ]; then
  brew install --cask --adopt mqttx nordvpn openvpn-connect arq docker steam balenaetcher vlc sonos 1password-cli qmk-toolbox k9s k3sup helm flux
fi

# Stow common packages
cd "$DOTFILES_DIR"
stow ghostty bat fish nvim tmux git

# Stow environment packages
if [ "$SETUP_MODE" = "home" ]; then
  stow qmk
fi

# Node
cd "$HOME"
fnm install --lts
fnm default lts-latest

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
fish -c "if not type -q fisher; curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher; end"

# TPM
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Done! Run ./macos.sh to apply system defaults, then restart your shell."
