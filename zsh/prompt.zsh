autoload colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_status_block() {
  local git_status="";
  local INDEX=$($git status --porcelain -b 2> /dev/null);

  local is_ahead=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    git_status="⇡$git_status"
  fi

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    git_status="?$git_status"
  fi

  if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
    git_status="+$git_status"
  elif $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
    git_status="+$git_status"
  elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
    git_status="+$git_status"
  fi

  if $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
    git_status="!$git_status"
  fi

  if $(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null); then
    git_status="»$git_status"
  fi

  if $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null); then
    git_status="✘$git_status"
  elif $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null); then
    git_status="✘$git_status"
  fi

  if [[ -n $git_status ]]; then
    echo "%{$fg_bold[red]%}[$git_status]%{$reset_color%}"
  fi
}

git_prompt() {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
 echo "%{$reset_color%}(%{$fg_bold[magenta]%}${ref#refs/heads/}%{$reset_color%}$(git_status_block))"

}

construct_dir() {
    echo ${${:-/${(j:/:)${(M)${(s:/:)${(D)PWD:h}}#(|.)[^.]}}/${PWD:t}}//\/~/\~}
}
directory_name() {
  # echo "%{$fg_bold[cyan]%}%~%{$reset_color%}"
  echo "%{$fg_bold[yellow]%}$(construct_dir)/%{$reset_color%}"
}

prompt_icon() {
  if [[ $RETVAL -eq 0 ]]; then
    # echo "%{$fg_bold[green]%}➜  %{$reset_color%}"
    echo "%{$fg_bold[green]%} ➜  %{$reset_color%}"
  else
    echo "%{$fg_bold[red]%} ✘ %{$reset_color%}"
  fi
}

export PROMPT=$'$(directory_name)$(git_prompt)$(prompt_icon)'
set_prompt () {
  
  export RPROMPT="%{$fg_bold[black]%}%{$reset_color%}"
}

precmd() {
  RETVAL=$? # must be first line executed
  title "zsh" "%~\a " "%55<...<%~"
  set_prompt
}
