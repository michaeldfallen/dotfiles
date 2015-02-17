autoload colors && colors
source $DOTFILES/zsh/git-prompt/git-base.sh

git_prompt () {
  local=""
  remote=""
  local_ahead="$(commits_ahead_of_remote)"
  local_behind="$(commits_behind_of_remote)"
  remote_ahead="$(remote_ahead_of_master)"
  remote_behind="$(remote_behind_of_master)"
  remote_master="𝘮"

  ahead_arrow="%{$fg_bold[green]%}↑%{$reset_color%}"
  behind_arrow="%{$fg_bold[red]%}↓%{$reset_color%}"
  diverged_arrow="%{$fg_bold[yellow]%}⇵%{$reset_color%}"
  behind_remote_arrow="%{$fg_bold[red]%}→%{$reset_color%}"
  ahead_remote_arrow="%{$fg_bold[green]%}←%{$reset_color%}"
  diverged_remote_arrow="%{$fg_bold[yellow]%}⇄%{$reset_color%}"

  if [[ "$local_behind" -gt "0" && "$local_ahead" -gt "0" ]]; then
    local=" $local_ahead$diverged_arrow$local_behind"
  elif [[ "$local_behind" -gt "0" ]]; then
    local=" $local_behind$behind_arrow"
  elif [[ "$local_ahead" -gt "0" ]]; then
    local=" $local_ahead$ahead_arrow"
  fi

  if [[ "$remote_behind" -gt "0" && "$remote_ahead" -gt "0" ]]; then
    remote="$remote_master $remote_ahead $diverged_remote_arrow $remote_behind "
  elif [[ "$remote_behind" -gt "0" ]]; then
    remote="$remote_master $ahead_remote_arrow $remote_behind "
  elif [[ "$remote_ahead" -gt "0" ]]; then
    remote="$remote_master $remote_ahead $behind_remote_arrow "
  fi

  branch="%{$fg[white]%}$(branch_name)%{$reset_color%}"
  git_prefix="%{$fg_bold[black]%}git:(%{$reset_color%}"
  git_suffix="%{$fg_bold[black]%})%{$reset_color%}"

  if is_repo; then
    prompt=" $git_prefix$remote$branch$local$git_suffix"
  fi

  echo "$prompt"
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

ret_status() {
  echo "%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
}

export PROMPT=$'$(ret_status)$(directory_name)$(git_prompt) '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
