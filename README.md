# dotfiles

Personal machine configuration for Fish, Neovim, tmux, git, and more. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a stow package that mirrors the target filesystem from `$HOME`:

```
alacritty/  → ~/.config/alacritty/
bat/        → ~/.config/bat/
fish/       → ~/.config/fish/
git/        → ~/.gitconfig, ~/.gitignore, ~/.gitconfig-public-user
git-work/   → ~/.gitconfig-work-user  (work machines only)
nvim/       → ~/.config/nvim/
qmk/        → ~/.config/qmk/          (home machines only)
tmux/       → ~/.config/tmux/
tmuxinator/ → ~/.config/tmuxinator/
```

## Fresh install

```sh
git clone git@github.com:ajclarkson/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install.sh [home|work]
```

This installs Homebrew (if needed), CLI tools, applications, stows all packages, sets up Node via fnm, and sets Fish as the default shell.

After installing, apply macOS system defaults:

```sh
./macos.sh
```

## Adding a machine to an existing install

If everything is already installed and you just need the symlinks:

```sh
cd ~/workspace/dotfiles
stow alacritty bat fish git nvim tmux tmuxinator

# home machines
stow qmk

# work machines
stow git-work
```

## Updating

```sh
./update.sh
```

Runs macOS software updates, updates Node via fnm, and upgrades Homebrew packages.

## Notes

- Secrets (Slack tokens, API keys) live in `fish/.config/fish/ajclarkson/secrets.fish` which is gitignored
- Git identity is handled automatically via `includeIf` in `.gitconfig` — the correct user config is picked based on the remote URL
- tmux plugins are managed by [tpm](https://github.com/tmux-plugins/tpm) at `~/.tmux/plugins/`, not in this repo. Install them with `prefix + I` inside tmux after first run
- Cloudflare WARP can cause certificate errors during install — disable it first if you hit issues

## Credit

- [ThePrimeagen Neovim setup](https://www.youtube.com/watch?v=w7i4amO_zaE)
- [stefanjudis](https://github.com/stefanjudis/dotfiles)
