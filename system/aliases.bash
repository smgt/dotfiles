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
alias taskpaper="vim ~/Dropbox/todo.taskpaper"
alias task="taskpaper"
alias m="mvim"
alias mt="mvim --remote-tab"
