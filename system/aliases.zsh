# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# grc overides for ls
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Shortcuts
alias .d="cd ~/.dotfiles"
alias d="cd ~/Dropbox"
alias thesis="cd ~/Cloud/PhD/Thesis"
alias p="cd ~/Projects"
alias g="git"

# IP addresses
alias ip="curl icanhazip.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"


# Mac Specific aliases
if [[ $(uname) = 'Darwin' ]]; then
  # Flush Directory Service cache
  alias fdns="sudo discoveryutil mdnsflushcache && sudo discoveryutil udnsflushcaches"

  # Clean up LaunchServices to remove duplicates in the “Open With” menu
  alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

  # Show/hide hidden files in Finder
  alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  # Lock the screen (when going AFK)
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi
