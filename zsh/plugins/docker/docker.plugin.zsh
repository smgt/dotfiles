# Docker Plugin

# Author: Simon Gate
# Date: 16 Oct, 2015

function docker_containers {
  docker ps --format "{{.ID}} {{.Names}}"
}

function docker_enter {

  if [ ! -n "$1" ];then
    echo "Available machines: "
    docker_containers
    return
  fi

  docker ps --format "{{.ID}}\n{{.Names}}" | grep -q ^${1}$
  RESULT=$?

  if [ $RESULT -ne 0 ] ; then
    echo "Available machines: $(docker-machine ls -q)"
  else
    echo "Setting docker env to $1"
    eval "$(docker-machine env $1)"
  fi
}

# auto complete
_dockermachine_complete() {
  D=$(dockermachine_env_list)
  _arguments ":::($D)"
}

compdef _dockermachine_complete dockermachine_env
# compdef _apparix_complete apparix_delete

# alias to=apparix_to
# alias al=apparix_list
# alias aa=apparix_add
