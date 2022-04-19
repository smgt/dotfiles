# create new ssh agent session
SSH_AGENT_ENV="$HOME/.ssh-agent.env"

ssh-add -l &>/dev/null
if [ "$?" -eq 2 ]; then
  test -r "$SSH_AGENT_ENV" && \
    eval "$(<"$SSH_AGENT_ENV")" >/dev/null

  ssh-add -l &>/dev/null
  if [ "$?" -eq 2 ]; then
    (umask 066; ssh-agent > "$SSH_AGENT_ENV")
    eval "$(<"$SSH_AGENT_ENV")" >/dev/null
  fi
fi
