# https://github.com/asdf-vm/asdf
if [[ -f "$HOME/.asdf/asdf.sh" ]];then
  . $HOME/.asdf/asdf.sh
elif [[ -f "/opt/asdf-vm/asdf.sh" ]];then
  . /opt/asdf-vm/asdf.sh
fi

# Load direnv
# command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]];then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
fi

if command -v fzf > /dev/null 2>&1; then
  #source /usr/share/fzf/key-bindings.zsh
  #source /usr/share/fzf/completion.zsh
fi

# direnv alternative that plays nicely with nix develop
# see https://github.com/nix-community/nix-direnv/issues/324
# see https://github.com/direnv/direnv/issues/1084
# function enterNixDevelopShell {
#   if test -f flake.nix; then nix develop . --impure; fi
# }
# chpwd_functions=(''${chpwd_functions[@]} "enterNixDevelopShell")
