autoload colors && colors

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

ret_status() {
  echo "%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
}

git_radar() {
  USE_RADAR="${USE_RADAR:-"true"}"
  if [[ $USE_RADAR == "true" ]]; then
    USE_DEV_RADAR="${USE_DEV_RADAR:-"false"}"
    if [[ $USE_DEV_RADAR == "true" ]]; then
      printf ' - dev -'
      ~/Projects/personal/git-radar/git-radar --zsh --fetch
    else
      git-radar --zsh --fetch
    fi
  fi
}

export PROMPT=$'$(ret_status)$(directory_name)$(git_radar) '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "${PWD##*/}"
  set_prompt
}

preexec() {
  title "zsh" "%m" "${PWD##*/} - $2"
}

function TRAPUSR1() {
  # reset proc number
  ASYNC_PROC=0

  # redisplay
  zle && zle reset-prompt
}
