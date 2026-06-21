if status is-interactive
    # Directory hops
    abbr w 'cd ~/workspace'
    abbr .d 'cd ~/workspace/dotfiles'

    # Git commands
    abbr gc 'git commit -m'
    abbr gp 'git pull'
    abbr gst 'git status --short --branch'
    abbr gs 'git add .'
    abbr gus 'git reset HEAD'
    abbr guc 'git reset --soft HEAD^'
    abbr gg 'git push'
    abbr gb 'git branch'
    abbr gco 'git checkout'

    # Good looking lists
    abbr ll 'exa -la --git --icons'

    # Grab your ip address
    abbr ip "echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

    # Raycast aliases
    abbr raylog "log stream --predicate \"subsystem == 'com.raycast.macos'\" --level debug --style compact"

    # Tmux aliases
    abbr tat 'tmux attach -t'
    abbr tls 'tmux ls'
    abbr mux 'tmuxinator'
    abbr ts 'tmuxinator start'

    # Open obsidian vault
    abbr vault 'cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain/" && tmuxinator'
end
