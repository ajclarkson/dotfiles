# Dotfiles

GNU Stow-based dotfiles for macOS. Each top-level directory is a stow package that mirrors `$HOME`.

## Layout

| Package | Target |
|---|---|
| `bat/` | `~/.config/bat/` |
| `claude/` | `~/.claude/` (partial — real dir with session/cache/credentials, only specific files stowed) |
| `fish/` | `~/.config/fish/` (partial — real dir with other fish-managed files) |
| `ghostty/` | `~/.config/ghostty/` |
| `git/` | `~/.config/git/` |
| `nvim/` | `~/.config/nvim/` |
| `tmux/` | `~/.config/tmux/` |

`.stowrc` sets `--target=~` so `stow <package>` works without flags.

To stow everything: `stow bat claude fish ghostty git nvim tmux`

## Known quirks

**`claude/` is a partial stow target.** `~/.claude/` is a real directory full of session state, caches, and `.credentials.json` — none of that is tracked. Only `statusline-command.sh` is stowed. It self-detects which machine it's on: if the `claude-usage` binary is present (work) it shows today's/average spend, otherwise it falls back to reading `.rate_limits.five_hour`/`.seven_day` from the statusline JSON (personal, Pro/Max plan). `~/.claude/settings.json` (which points `statusLine` at this script and holds work-only hooks/MCP config) is machine-specific and intentionally not stowed — it must already point to `~/.claude/statusline-command.sh` on each machine for this to take effect.

**`fish/` is a partial stow target.** `~/.config/fish/` is a real directory (fish manages files there itself). Stow creates symlinks for `config.fish` and `ajclarkson/` inside it, leaving fish's own files untouched.

**`nvim/` is tree-folded.** Stow symlinks the whole `~/.config/nvim` directory. `lazy-lock.json` lives there but is gitignored — it won't appear as a tracked change.

**`ghostty/` is tree-folded.** Stow symlinks the whole `~/.config/ghostty` directory. Ghostty doesn't reliably hot-reload config/icon changes pulled via git — fully quit (Cmd+Q) and relaunch after pulling changes to this package.

## Gitignored local files

These exist on disk but are never committed:
- `fish/.config/fish/ajclarkson/secrets.fish` — shell secrets/tokens
- `fish/.config/fish/fish_variables` — fish's own variable store
- `nvim/.config/nvim/lazy-lock.json` — lazy.nvim lockfile

## install.sh

Bootstraps a fresh machine: installs Homebrew, CLI tools, GUI apps, stows all packages, sets up fish, TPM, fnm. Takes `home` or `work` as an argument for conditional installs.
