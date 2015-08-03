autoload colors && colors
source $DOTFILES/zsh/git-prompt/git-base.sh

local ahead_arrow="%{$fg_bold[green]%}↑%{$reset_color%}"
local behind_arrow="%{$fg_bold[red]%}↓%{$reset_color%}"
local diverged_arrow="%{$fg_bold[yellow]%}⇵%{$reset_color%}"
local behind_remote_arrow="%{$fg_bold[red]%}→%{$reset_color%}"
local ahead_remote_arrow="%{$fg_bold[green]%}←%{$reset_color%}"
local diverged_remote_arrow="%{$fg_bold[yellow]%}⇄%{$reset_color%}"
local git_prefix="%{$fg_bold[black]%}git:(%{$reset_color%}"
local git_suffix="%{$fg_bold[black]%})%{$reset_color%}"
local not_upstream="%{$fg_bold[red]%}⚡%{$reset_color%}"
local remote_master="𝘮"

git_prompt () {
  nohup $DOTFILES/zsh/git-prompt/fetch.sh >/dev/null &

  prompt_str=""
  local=""
  remote=""
  if is_repo; then

    if remote_branch="$(remote_branch_name)"; then
      local_ahead="$(commits_ahead_of_remote "$remote_branch")"
      local_behind="$(commits_behind_of_remote "$remote_branch")"
      remote_ahead="$(remote_ahead_of_master "$remote_branch")"
      remote_behind="$(remote_behind_of_master "$remote_branch")"

      if [[ "$local_behind" -gt "0" && "$local_ahead" -gt "0" ]]; then
        local=" $local_behind$diverged_arrow$local_ahead"
      elif [[ "$local_behind" -gt "0" ]]; then
        local=" $local_behind$behind_arrow"
      elif [[ "$local_ahead" -gt "0" ]]; then
        local=" $local_ahead$ahead_arrow"
      fi

      if [[ "$remote_behind" -gt "0" && "$remote_ahead" -gt "0" ]]; then
        remote="$remote_master $remote_behind $diverged_remote_arrow $remote_ahead "
      elif [[ "$remote_ahead" -gt "0" ]]; then
        remote="$remote_master $ahead_remote_arrow $remote_ahead "
      elif [[ "$remote_behind" -gt "0" ]]; then
        remote="$remote_master $remote_behind $behind_remote_arrow "
      fi
    else
      remote="upstream $not_upstream "
    fi

    branch="%{$fg[white]%}$(readable_branch_name)%{$reset_color%}"
    prompt_str=" $git_prefix$remote$branch$local$git_suffix$(zsh_color_changes_status)"
  fi

  echo "$prompt_str"
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
  title "zsh" "%m" "${PWD##*/}"
  set_prompt
}

preexec() {
  title "zsh" "%m" "${PWD##*/} - $2"
}
