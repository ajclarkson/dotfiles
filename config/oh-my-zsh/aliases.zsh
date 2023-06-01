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