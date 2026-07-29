set -gx EDITOR "nvim"
set -gx OBSIDIAN_DIR "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain/"

# Fixed npm global install location, independent of fnm's active/default node version
set -gx NPM_CONFIG_PREFIX "$HOME/.npm-global"

# Work-only: gcloud CLI needs a Python it's compatible with. Guarded on the
# binary's presence (self-detects work vs. personal machine) rather than a
# separate stow package, since it's a single variable.
if test -x /opt/homebrew/bin/python3.12
    set -gx CLOUDSDK_PYTHON /opt/homebrew/bin/python3.12
end

