if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="yellow"; fi

PROMPT='%{$fg[$NCOLOR]%}%m %{$fg_bold[blue]%}%1/%\/ %{$fg_bold[green]%}➤ %{$reset_color%}'
RPROMPT='%p $(~/.dotfiles/bin/chef_org) $(git_prompt_ahead) $(parse_git_dirty)$(current_branch)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%}⬆"
