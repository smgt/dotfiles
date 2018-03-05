if (( $+command[mvim] ));then
  export VIM_BIN==mvim
else
  export VIM_BIN==vim
fi

function vim() {
  if [ -f ".lvimrc" ]; then
    $VIM_BIN -S .lvimrc $*
  else
    $VIM_BIN $*
  fi
}

function mvim() {
  if [ -f ".lvimrc" ]; then
    $VIM_BIN -S .lvimrc $*
  else
    $VIM_BIN $*
  fi
}

alias m="mvim"
alias mt="mvim --remote-tab"
alias v="vim"

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
