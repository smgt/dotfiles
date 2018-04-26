if [ ! -f $HOME/.antigen/antigen.zsh ];then
  git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
fi

if [ -f $HOME/.antigen/antigen.zsh ];then
  source $HOME/.antigen/antigen.zsh
  # Antigen
  # Bundles from oh-my-zsh
  antigen use oh-my-zsh
  antigen bundle aws
  antigen bundle git
  antigen bundle git-extras
  antigen bundle extract
  antigen bundle bundler
  antigen bundle docker
  antigen bundle docker-compose
  antigen bundle tmux
  antigen bundle vagrant
  antigen bundle node
  antigen bundle nvm
  antigen bundle command-not-found
  antigen bundle gem
  antigen bundle pip
  antigen bundle ssh-agent

  # other plugins
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle chrissicool/zsh-256color
  #Tarrasch/zsh-bd

  antigen apply
fi
