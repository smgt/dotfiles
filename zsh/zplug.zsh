source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "chrissicool/zsh-256color"
#zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/git",   from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
