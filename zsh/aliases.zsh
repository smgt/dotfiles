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

if type nvim &> /dev/null; then
  export VIM_BIN=nvim
else
  export VIM_BIN=vim
fi

alias v=$VIM_BIN
alias vim=$VIM_BIN
