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
  alias ll="gls -l --color"
  alias la='gls -A --color'
else
  alias ls="ls -F --color"
  alias l="ls -a --color"
  alias ll="ls -l --color"
  alias la="ls -A --color"
fi

alias flushdns="dscacheutil -flushcache"
alias grep="grep --color"
alias -g biggu=/Volumes/Biggu

# Basic directory operations
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'

alias -- -='cd -'

# # Super user
alias _='sudo'

## Mutt in english
alias mutt="LANG=en_US mutt"
# The rest of my fun git aliases
#alias gl='git pull --prune'
alias ga='git add'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gdt='git difftool'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gw='git wtf'
#   # syntax is way
