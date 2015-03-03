autoenv="$(brew list autoenv)"

if [[ -n "$autoenv" ]]; then
  source /usr/local/opt/autoenv/activate.sh
fi
