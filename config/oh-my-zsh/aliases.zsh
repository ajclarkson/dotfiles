# Navigation
alias w="cd ~/workspace"

# Git Aliases
alias gc="git commit -m"
alias gco="git checkout"
alias gp="git pull"
alias gst="git status --short --branch"
alias gs="git add ."
alias gus="git reset HEAD"
alias guc="git reset --soft HEAD^"
alias ggo='() { git checkout -b $1 2> /dev/null || git checkout $1;}'
alias gg="git push"

# Good looking lists
alias ll='exa -la --git --icons'

# Better / colored cat command
alias cat='bat'

# Grab your ip address
alias ip="echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

# Raycast aliases
alias raylog="log stream --predicate \"subsystem == 'com.raycast.macos'\" --level debug --style compact"

# Suffix aliases
# https://www.stefanjudis.com/today-i-learned/suffix-aliases-in-zsh/
alias -s {js,json,env,gitignore,md,html,css,toml}=cat
alias -s git="clone"