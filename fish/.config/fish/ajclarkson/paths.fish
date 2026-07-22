# Set up the path

# Add homebrew location for arm mac
set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths

# Add fnm default node bin so npm global tools (e.g. tree-sitter-cli) are available everywhere
set -l _fnm_default_bin (fnm exec --using=default -- sh -c 'dirname $(which node)' 2>/dev/null)
if test -d "$_fnm_default_bin"
    fish_add_path "$_fnm_default_bin"
end


