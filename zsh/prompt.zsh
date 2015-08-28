autoload colors && colors

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

ret_status() {
  echo "%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
}

export PROMPT=$'$(ret_status)$(directory_name)$(git-radar --zsh --fetch) '
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
