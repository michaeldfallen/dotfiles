autoload colors && colors
source $DOTFILES/zsh/git-prompt/git-base.sh

local ahead_arrow="%{$fg_bold[green]%}↑%{$reset_color%}"
local behind_arrow="%{$fg_bold[red]%}↓%{$reset_color%}"
local diverged_arrow="%{$fg_bold[yellow]%}⇵%{$reset_color%}"
local behind_remote_arrow="%{$fg_bold[red]%}→%{$reset_color%}"
local ahead_remote_arrow="%{$fg_bold[green]%}←%{$reset_color%}"
local diverged_remote_arrow="%{$fg_bold[yellow]%}⇄%{$reset_color%}"
local remote_master="𝘮"

git_prompt () {
  nohup $DOTFILES/zsh/git-prompt/fetch.sh >/dev/null &

  prompt_str=""
  local=""
  remote=""
  remote_branch="$(remote_branch_name)"
  local_ahead="$(commits_ahead_of_remote "$remote_branch" )"
  local_behind="$(commits_behind_of_remote "$remote_branch")"
  remote_ahead="$(remote_ahead_of_master "$remote_branch")"
  remote_behind="$(remote_behind_of_master "$remote_branch")"

  if [[ "$local_behind" -gt "0" && "$local_ahead" -gt "0" ]]; then
    local=" $local_ahead$diverged_arrow$local_behind"
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

  porcelain="$(porcelain_status)"
  if [[ -n "$porcelain" ]]; then
    staged_changes="$(staged_status "$porcelain")"
    unstaged_changes="$(unstaged_status "$porcelain")"
    untracked_changes="$(untracked_status "$porcelain")"
    conflicted_changes="$(conflicted_status "$porcelain")"
    if [[ -n "$staged_changes" ]]; then
      staged_changes=" $staged_changes"
    fi

    if [[ -n "$unstaged_changes" ]]; then
      unstaged_changes=" $unstaged_changes"
    fi

    if [[ -n "$conflicted_changes" ]]; then
      conflicted_changes=" $conflicted_changes"
    fi

    if [[ -n "$untracked_changes" ]]; then
      untracked_changes=" $untracked_changes"
    fi

    changes="$staged_changes$conflicted_changes$unstaged_changes$untracked_changes"
  fi

  branch="%{$fg[white]%}$(readable_branch_name)%{$reset_color%}"
  git_prefix="%{$fg_bold[black]%}git:(%{$reset_color%}"
  git_suffix="%{$fg_bold[black]%})%{$reset_color%}"

  if is_repo; then
    prompt_str=" $git_prefix$remote$branch$local$git_suffix$changes"
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
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
