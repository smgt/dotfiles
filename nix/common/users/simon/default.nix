{ config, pkgs, ... }:
let 
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  catppuccin.url = "github:catppuccin/nix";
    tmux-catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-catppuccin";
      version = "unstable-2024-11-17";
      rtpFilePath = "catppuccin.tmux";
      postInstall = ''
        sed -i -e 's|''${PLUGIN_DIR}/catppuccin_options_tmux.conf|'$target'/catppuccin_options_tmux.conf|g' $target/catppuccin.tmux
        sed -i -e 's|''${PLUGIN_DIR}/catppuccin_tmux.conf|'$target'/catppuccin_tmux.conf|g' $target/catppuccin.tmux
      '';
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "tmux";
        rev = "179572333b0473020e45f34fd7c1fd658b2831f4";
        sha256 = "sha256-9+SpgO2Co38I0XnEbRd7TSYamWZNjcVPw6RWJIHM+4c=";
      };
    };

in {
  home = {
    sessionVariables = {
      DOTFILES = "$HOME/.dotfiles";
      GPG_TTY = "$(tty)";
      BAT_THEME = "ansi";
      PAGER = "less -R";
    };

    sessionPath = [ "$HOME/bin" "$DOTFILES/bin" ];

    packages = [
      # Tooling
      pkgs.entr
      pkgs.buf
      pkgs.docker-compose
      # Language servers
      unstable.yaml-language-server
      unstable.vscode-langservers-extracted
      pkgs.gopls
      unstable.harper
      unstable.terraform-ls
      unstable.nil
      # Linters
      pkgs.hadolint
      unstable.golangci-lint
      pkgs.checkmate
      pkgs.write-good
      pkgs.statix
      pkgs.semgrep
      pkgs.gosec
      pkgs.revive
      pkgs.checkmate
      # Formatters
      pkgs.gofumpt
      pkgs.gotools
      pkgs.hclfmt
      pkgs.nixfmt-rfc-style
      # Go
      pkgs.delve
      pkgs.impl
    ];
  };

  xdg.enable = true;
  services = { ssh-agent.enable = true; };

  programs = {
    # xdg.configFile.nvim = {
    #   source = ../../../../neovim;
    #   recursive = true;
    # };

    # Enable direnv and nix-direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      config = { global = { warn_timeout = "5m"; }; };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    git = {
      enable = true;
      userName = "Simon Gate";
      userEmail = "simon@kampgate.se";
      #diff-so-fancy.enable = true;
      difftastic.enable = true;
      includes = [{
        condition = "hasconfig:remote.*.url:git@gitlab.com:readly-ab/**";
        contents = { user = { email = "simon.gate@readly.com"; }; };
      }];
      ignores = [ ".direnv" "tmp" ".DS_Store" "*.swp" ".env" ];
      extraConfig = {
        init.defaultBranch = "main";
        lfs.enable = true;
        branch.sort = "-committerdate";
        pull.rebase = true;
        push.autosetupremote = true;
        github.user = "smgt";
        core.editor = "nvim";
        color = { ui = "auto"; };
        merge = { conflictstyle = "diff3"; };
      };
    };

    awscli = { enable = true; };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "ansi";
      };
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "*" = { forwardAgent = false; };
        "smgt-dev" = { hostname = "100.93.118.110"; };
        "logs.dev.readly.com" = {
          user = "ubuntu";
          proxyJump = "ec2-user@nat.dev.readly.com";
        };
        "10.0.* !nat.dev.readly.com" = {
          user = "ubuntu";
          proxyJump = "ec2-user@nat.dev.readly.com";
        };
        "10.10.*" = {
          user = "ubuntu";
          proxyJump = "ec2-user@nat.vpc.eu.readly.com";
        };
        "*.vpc.eu.readly.com !nat.vpc.eu.readly.com" = {
          user = "ubuntu";
          proxyJump = "ec2-user@nat.vpc.eu.readly.com";
        };
      };
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      baseIndex = 1;
      mouse = false;
      prefix = "C-a";
      aggressiveResize = true;
      clock24 = true;
      plugins = with pkgs; [
        {
          plugin = tmux-catppuccin;
          extraConfig = ''
          set -g @catppuccin_flavor 'frappe'
          set -g @catppuccin_status_left_separator ""
          set -g "@catppuccin_host_icon" " 󰒋 "
          set -g "@catppuccin_session_icon" "  "
          set -g "@catppuccin_date_time_icon" " 󰃰 "
          '';
        }
        tmuxPlugins.fzf-tmux-url
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.sensible
      ];
      extraConfig = ''
        # Allow passthrough codes for ESCAPE codes
        set -g allow-passthrough on
        # Set escape time to get rid of the lag in nvim when pressing ESC
        set -sg escape-time 0
        # Neovim
        set-option -g focus-events on

        # quick pane cycling
        unbind ^A
        bind ^A select-pane -t :.+

        # Sexy look
        # Add truecolor support
        set-option -ga terminal-overrides ",*256col*:Tc,wezterm:Tc,xterm-kitty:Tc"

        # Default terminal is 256 colors
        set -g default-terminal "tmux-256color"
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

        set -g set-titles-string '#{pane_title}'

        # Set the current working directory based on the current pane's current
        # working directory (if set; if not, use the pane's starting directory)
        # when creating # new windows and splits.
        bind-key c new-window -c '#{pane_current_path}'
        bind-key '"' split-window -c '#{pane_current_path}'
        bind-key % split-window -h -c '#{pane_current_path}'

        # Open the new session in the current directory
        bind-key S command-prompt "new-session -A -c '#{pane_current_path}' -s '%%'"

        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_host}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
      '';
    };

    neovim = {
      enable = true;
      package = unstable.neovim-unwrapped;
      defaultEditor = true;
      #extraLuaConfig = lib.fileContents ../../neovim/init.lua;
      viAlias = true;
      vimAlias = true;
      # plugins = [
      #   pkgs.vimPlugins.packer-nvim
      # ];
      extraPackages = with pkgs; [ tree-sitter ];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
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
          { name = "zsh-users/zsh-syntax-highlighting"; }
          { name = "chrissicool/zsh-256color"; }
          #{ name = "jeffreytse/zsh-vi-mode"; }
          #{ name = "zsh-users/zsh-autosuggestions"; }
          { name = "plugins/git"; tags = [ "from:oh-my-zsh" ]; }
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
        ls = "ls -F --color";
        l = "ls -a --color";
        ll = "ls -lh --color";
        la = "ls -A --color";
      };

      initExtra = ''
        # Load custom prompts
        fpath=($DOTFILES/zsh/prompts $fpath)
        autoload -Uz promptinit; promptinit
        prompt smgt

        #source $DOTFILES/zsh/prompt.zsh

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

        autoload -U $HOME/.dotfiles/zsh/functions/*(:t)

        # Load local config file
        [[ -a ~/.localrc ]] && source ~/.localrc
      '';
    };

    go = {
      enable = true;
      goPrivate = [ "gitlab.com/readly-ab" "buf.build/gen/go" ];
    };

    fd = {
      enable = true;
      hidden = true;
      ignores = [ "vendor/" ".git/" "npm_modules" ".terraform" ];
    };

    ripgrep = {
      enable = true;
      arguments = [ "--glob=!git/*" "--glob=!vendor/*" "--smart-case" ];
    };

    home-manager.enable = true;
  };
}
