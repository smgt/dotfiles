# https://github.com/asdf-vm/asdf
if [[ -f "$HOME/.asdf/asdf.sh" ]];then
  . $HOME/.asdf/asdf.sh
elif [[ -f "/opt/asdf-vm/asdf.sh" ]];then
  . /opt/asdf-vm/asdf.sh
fi

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
if command -v fzf > /dev/null 2>&1; then
  #source /usr/share/fzf/key-bindings.zsh
  #source /usr/share/fzf/completion.zsh
fi
