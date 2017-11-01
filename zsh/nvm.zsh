if [ -f '/usr/local/opt/nvm/nvm.sh' ];then
  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
fi

if [ -f '/usr/share/nvm/init-nvm.sh' ];then
  export NVM_DIR="$HOME/.nvm"
  . "/usr/share/nvm/init-nvm.sh"
fi
