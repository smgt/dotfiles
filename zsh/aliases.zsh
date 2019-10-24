alias dotvim='vim $DOTFILES'
alias dotcd='cd $DOTFILES'
alias reload!='. ~/.zshrc'

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -lh --color"
  alias la='gls -A --color'
else
  alias ls="ls -F --color"
  alias l="ls -a --color"
  alias ll="ls -lh --color"
  alias la="ls -A --color"
fi

alias grep="grep --color"

# Basic directory operations
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'

alias -- -='cd -'

# # Super user
alias _='sudo'

## Mutt in english
alias mutt="LANG=en_US mutt"

alias tmux="TERM=screen-256color-bce tmux"

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
