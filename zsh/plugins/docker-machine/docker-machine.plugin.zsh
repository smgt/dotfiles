# Docker-Machine Plugin

# Author: Simon Gate
# Date: 15 Oct, 2015

function dockermachine_list {
  docker-machine ls -q
}

function dockermachine_env {

  if [ ! -n "$1" ];then
    echo "Available machines: $(docker-machine ls -q)"
    return
  fi

  docker-machine ls -q | grep -q ^${1}$
  RESULT=$?

  if [ $RESULT -ne 0 ] ; then
    echo "Available machines: $(docker-machine ls -q)"
  else
    echo "Setting docker env to $1"
    eval "$(docker-machine env $1)"
  fi
}

function dockermachine_config {
  docker-machine config ${1}
}

# auto complete
_dockermachine_complete() {
  D=$(dockermachine_list)
  _arguments ":::($D)"
}

compdef _dockermachine_complete dockermachine_env
compdef _dockermachine_complete dockermachine_config
alias dme=dockermachine_env
alias dmc=dockermachine_config
