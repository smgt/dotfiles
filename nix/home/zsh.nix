{...}: {
  programs.zsh = {
    enable = true;
    # dotDir = "${config.xdg.dataHome}/zsh";
    enableCompletion = true;
    defaultKeymap = "viins";

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-syntax-highlighting";}
        {
          name = "chrissicool/zsh-256color";
        }
        #{ name = "jeffreytse/zsh-vi-mode"; }
        #{name = "zsh-users/zsh-autosuggestions";}
        {
          name = "plugins/git";
          tags = ["from:oh-my-zsh"];
        }
      ];
    };

    shellAliases = {
      dotvim = "pushd $DOTFILES && $EDITOR . && popd";
      dotcd = "cd $DOTFILES";
      grep = "grep --color";
      "...." = "cd ../../..";
      "..." = "cd ../..";
      ".." = "cd ..";
      "-- -" = "cd -"; # not working
      "_" = "sudo";
      v = "$EDITOR";
      n = "$EDITOR";
      e = "$EDITOR";
      vim = "$EDITOR";
      ls = "ls -F --color";
      l = "ls -a --color";
      ll = "ls -lh --color";
      la = "ls -A --color";
    };

    initContent = ''
      # Load custom prompts
      fpath=($HOME/.config/zsh $fpath)
      autoload -Uz promptinit; promptinit
      prompt smgt

      setopt NO_BG_NICE # don't nice background tasks
      setopt NO_HUP
      setopt NO_LIST_BEEP
      #setopt LOCAL_OPTIONS # allow functions to have local options
      setopt LOCAL_TRAPS # allow functions to have local traps
      setopt PROMPT_SUBST
      setopt COMPLETE_IN_WORD
      setopt IGNORE_EOF

      if type nvim > /dev/null 2>&1;then
        export NVIM_REMOTE_SOCK=~/.cache/nvim/nvim.sock
        export EDITOR=nvim
      else
        export EDITOR=vim
      fi

      #bindkey '^[OD' backward-word # Ctrl+arrow left
      #bindkey '^[OC' forward-word # Ctrl + arrow right
      bindkey '^[^[[D' beginning-of-line # ESC + arrow left
      bindkey '^[^[[C' end-of-line # ESC + arrow right
      bindkey '^[[3~' delete-char
      bindkey '^[^N' newtab
      #bindkey '^?' backward-delete-char
      #bindkey '^R' history-incremental-search-backward
      #bindkey "^[[A" history-search-backward
      #bindkey "^[[B" history-search-forward

      autoload colors && colors
      autoload -U promptinit && promptinit

      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line

      # Verbose completion
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:descriptions' format '%B%d%b'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:warnings' format 'No matches for: %d'
      zstyle ':completion:*' group-name ""

      # Load local config file
      [[ -a ~/.localrc ]] && source ~/.localrc
      [[ -a /run/secrets/rendered/default.env ]] && source /run/secrets/rendered/default.env
    '';
  };
}
