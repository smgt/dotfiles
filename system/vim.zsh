export VIM=`which mvim`

function vim() {
  if [ -f ".lvimrc" ]; then
    $VIM -v -S .lvimrc $*
  else
    $VIM -v $*
  fi
}

function mvim() {
  if [ -f ".lvimrc" ]; then
    $VIM -S .lvimrc $*
  else
    $VIM $*
  fi
}

alias m="mvim"
alias mt="mvim --remote-tab"
alias v="vim"
