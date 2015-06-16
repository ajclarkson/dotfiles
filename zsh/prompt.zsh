autoload colors && colors
# alot of the git stuff has been modified from
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "[${ref#refs/heads/}]"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo "%{$fg[magenta]%}⌃%{$reset_color%} "
  fi
}

in_hg() {
  if [[ -d .hg ]] || $(hg summary > /dev/null 2>&1); then
    echo 1
  fi
}

hg_dirty() {
  if [ $(in_hg) ]; then
   hg status 2> /dev/null | command grep -Eq '^\s*[ACDIM!?L]'
    if [ $pipestatus[-1] -eq 0 ]; then
      echo "%{$fg_bold[red]%}[<branch>]%{$reset_color%}"
    else
      echo "%{$fg_bold[green]%}[<branch>]%{$reset_color%}"
    fi
 fi

}

hg_prompt_info {
  hg prompt --angle-brackets "<%{$reset_color%}%{$fg[yellow]%}\
$(hg_dirty)>" 2>/dev/null
}

directory_name() {
  echo "%{$fg_bold[cyan]%}[%~]%{$reset_color%}"
}

export PROMPT=$'$(directory_name)$(hg_prompt_info)$(git_dirty)$(need_push)%{$fg[red]%}» '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
