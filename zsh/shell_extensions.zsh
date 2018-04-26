command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v rbenv > /dev/null 2>&1 && eval "$(rbenv init -)"
if command -v fzf > /dev/null 2>&1; then
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi

[[ -d "$HOME/.rvm" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -d "$HOME/.rvm" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
