# Set up the path

# Native installers (e.g. Claude Code) drop binaries here
fish_add_path "$HOME/.local/bin"

# Add homebrew location (Apple Silicon Mac, Intel Mac, or Linuxbrew)
for brew_bin in /opt/homebrew/bin /usr/local/bin /home/linuxbrew/.linuxbrew/bin
    if test -d $brew_bin
        set -g fish_user_paths $brew_bin $fish_user_paths
    end
end

# Add fnm default node bin so npm global tools (e.g. tree-sitter-cli) are available everywhere
set -l _fnm_default_bin (fnm exec --using=default -- sh -c 'dirname $(which node)' 2>/dev/null)
if test -d "$_fnm_default_bin"
    fish_add_path "$_fnm_default_bin"
end

# Fixed location for npm global installs (see NPM_CONFIG_PREFIX in variables.fish) —
# keeps global CLIs (e.g. gws) available regardless of which fnm node version is default
fish_add_path "$NPM_CONFIG_PREFIX/bin"


