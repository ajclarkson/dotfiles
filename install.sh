#!/usr/bin/env sh
set -e

SETUP_MODE=${1:-"default"}
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

echo "Installing dotfiles (mode: $SETUP_MODE, os: $OS)"

# Homebrew (macOS: Homebrew; headless Linux: Linuxbrew)
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # A fresh install isn't on PATH yet in this shell; get it there before
  # any of the brew commands below run
  if [ "$OS" = "Darwin" ]; then
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# CLI tools (cross-platform: Homebrew on macOS, Linuxbrew on headless Linux)
brew install stow git fish fnm neovim tmux tmuxinator bat ripgrep fzf eza curl jq wget coreutils fd tfenv tree-sitter zoxide

# Claude Code CLI (native installer: same on macOS and Linux, auto-updates)
curl -fsSL https://claude.ai/install.sh | bash

if [ "$OS" = "Darwin" ]; then
  # Core GUI apps
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
    slack
fi

if [ "$SETUP_MODE" = "work" ] && [ "$OS" = "Darwin" ]; then
  brew install --cask --adopt meetingbar
elif [ "$SETUP_MODE" = "home" ]; then
  brew install k9s k3sup helm fluxcd/tap/flux
  if [ "$OS" = "Darwin" ]; then
    brew install --cask --adopt mqttx nordvpn openvpn-connect arq docker steam balenaetcher vlc sonos 1password-cli
  fi
fi

# Stow common packages
cd "$DOTFILES_DIR"
stow bat fish nvim tmux git tmuxinator
if [ "$OS" = "Darwin" ]; then
  stow ghostty
fi

# Stow environment packages
if [ "$SETUP_MODE" = "home" ]; then
  stow tmuxinator-home
elif [ "$SETUP_MODE" = "work" ]; then
  stow tmuxinator-work
fi

# Node
cd "$HOME"
fnm install --lts
fnm default lts-latest

# Fixed npm global install location (see NPM_CONFIG_PREFIX in fish/variables.fish)
mkdir -p "$HOME/.npm-global"

# Fish as default shell
FISH_PATH="$(command -v fish)"

if [ "$SHELL" != "$FISH_PATH" ]; then
  grep -qxF "$FISH_PATH" /etc/shells || echo "$FISH_PATH" | sudo tee -a /etc/shells
  chsh -s "$FISH_PATH"
fi

# Fisher
fish -c "if not type -q fisher; curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher; end"

# TPM
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

if [ "$OS" = "Darwin" ]; then
  echo "Done! Run ./macos.sh to apply system defaults, then restart your shell."
else
  echo "Done! Restart your shell."
fi
