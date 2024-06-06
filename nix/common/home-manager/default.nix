{ nixosConfig, pkgs, ... }:
{
    home.stateVersion = nixosConfig.system.stateVersion;

    home.sessionVariables = {
      DOTFILES = "$HOME/.dotfiles";
      GPG_TTY = "$(tty)";
      BAT_THEME = "ansi";
      PAGER = "less -R";
    };

    home.sessionPath = [
      "$HOME/bin"
      "$DOTFILES/bin"
    ];

#    gpg-agent = {
#      enable = true;
#      defaultCacheTtl = 1800;
#      enableSshSupport = false;
#    };

    xdg.enable = true;

    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
    programs.git = {
      enable = true;
      userName = "Simon Gate";
      userEmail = "simon+nixos@kampgate.se";
    };

    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "ansi";
      };
    };

    xdg.configFile.nvim = {
      source = ../../../neovim;
      recursive = true;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      #extraLuaConfig = lib.fileContents ../../neovim/init.lua;
      viAlias = true;
      vimAlias = true;
      # plugins = [
      #   pkgs.vimPlugins.packer-nvim
      # ];
      extraPackages = with pkgs; [
        tree-sitter
      ];
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # xdg.configFile.zsh = {
    #   source = ../../zsh;
    #   recursive = true;
    # };

    programs.zsh = {
      enable = true;
      # dotDir = "${config.xdg.dataHome}/zsh";
      enableCompletion = true;

      history = {
        ignoreDups = true;
        save = 10000;
        size = 10000;
      };


      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-syntax-highlighting"; }
          { name = "chrissicool/zsh-256color"; }
          #{ name = "zsh-users/zsh-autosuggestions"; }
          { name = "plugins/git"; tags = ["from:oh-my-zsh"]; }
        ];
      };

      shellAliases = {
        grep = "grep --color";
        dotvim = "pushd $DOTFILES && $EDITOR . && popd";
        dotcd = "cd $DOTFILES";
        "...." = "cd ../../..";
        "..." = "cd ../..";
        ".." = "cd ..";
        "-- -" = "cd -"; # not working
        "_" = "sudo";
        v = "$EDITOR";
        n = "$EDITOR";
        ls = "ls -F --color";
        l = "ls -a --color";
        ll = "ls -lh --color";
        la = "ls -A --color";
      };

      initExtra = ''
        source $DOTFILES/zsh/prompt.zsh
        
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
        autoload -U compinit && compinit

        autoload -U edit-command-line
        zle -N edit-command-line
        bindkey '^X^E' edit-command-line

        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"

        # Load local config file
        if [[ -a ~/.localrc ]]
        then
          source ~/.localrc
        fi
      '';
    };

}
