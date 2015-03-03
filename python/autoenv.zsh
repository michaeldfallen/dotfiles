autoload -U add-zsh-hook

autoenv="$(brew list autoenv)"

autoenv_init_hook() {
  autoenv_init
}

if [[ -n "$autoenv" ]]; then
  source /usr/local/opt/autoenv/activate.sh
fi

add-zsh-hook chpwd autoenv_init_hook
