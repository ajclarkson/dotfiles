# Dotfiles

GNU Stow-based dotfiles for macOS. Each top-level directory is a stow package that mirrors `$HOME`.

## Layout

| Package | Target |
|---|---|
| `alacritty/` | `~/.config/alacritty/` |
| `bat/` | `~/.config/bat/` |
| `fish/` | `~/.config/fish/` (partial — real dir with other fish-managed files) |
| `git/` | `~/` |
| `nvim/` | `~/.config/nvim/` |
| `qmk/` | `~/.config/qmk/` |
| `tmux/` | `~/.config/tmux/` |
| `tmuxinator/` | `~/.config/tmuxinator/` |

`.stowrc` sets `--target=~` so `stow <package>` works without flags.

To stow everything: `stow alacritty bat fish git nvim tmux tmuxinator`

## Known quirks

**`~/.gitignore` isn't stowed automatically.** Stow skips `.gitignore` by default (treated as a VCS file). Create it manually:
```sh
ln -s workspace/dotfiles/git/.gitignore ~/.gitignore
```

**`fish/` is a partial stow target.** `~/.config/fish/` is a real directory (fish manages files there itself). Stow creates symlinks for `config.fish` and `ajclarkson/` inside it, leaving fish's own files untouched.

**`nvim/` is tree-folded.** Stow symlinks the whole `~/.config/nvim` directory. `lazy-lock.json` lives there but is gitignored — it won't appear as a tracked change.

## Gitignored local files

These exist on disk but are never committed:
- `fish/.config/fish/ajclarkson/secrets.fish` — shell secrets/tokens
- `fish/.config/fish/fish_variables` — fish's own variable store
- `nvim/.config/nvim/lazy-lock.json` — lazy.nvim lockfile

## install.sh

Bootstraps a fresh machine: installs Homebrew, CLI tools, GUI apps, stows all packages, sets up fish, TPM, fnm. Takes `home` or `work` as an argument for conditional installs.
