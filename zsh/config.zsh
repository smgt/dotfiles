#if [[ -n $SSH_CONNECTION ]]; then
#  export PS1='%m:%3~$(git_info_for_prompt)%# '
#else
#  export PS1='%3~$(git_info_for_prompt)%# '
#fi

#export LSCOLORS="exfxcxdxbxegedabagacad"
#export CLICOLOR=true

fpath=($DOTFILES/zsh/functions /usr/local/share/zsh/site-functions $fpath)

autoload -U $DOTFILES/zsh/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export KEYTIMEOUT=1
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
#setopt CORRECT # correct spelling
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

# Share history between sessions
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions

setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

zle -N newtab

bindkey '^[OD' backward-word # Ctrl+arrow left
bindkey '^[OC' forward-word # Ctrl + arrow right
bindkey '^[^[[D' beginning-of-line # ESC + arrow left
bindkey '^[^[[C' end-of-line # ESC + arrow right
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
#bindkey '^?' backward-delete-char
#bindkey '^R' history-incremental-search-backward
#bindkey "^[[A" history-search-backward
#bindkey "^[[B" history-search-forward
