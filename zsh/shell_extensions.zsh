[[ -f "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
if command -v fzf > /dev/null 2>&1; then
  #source /usr/share/fzf/key-bindings.zsh
  #source /usr/share/fzf/completion.zsh
fi
