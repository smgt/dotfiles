{ config, pkgs, ...}:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ../../home-manager
  ];

  home = {
    sessionVariables = {
      DOTFILES = "$HOME/.dotfiles";
      GPG_TTY = "$(tty)";
      BAT_THEME = "ansi";
      PAGER = "less -R";
    };

    sessionPath = [
      "$HOME/bin"
      "$DOTFILES/bin"
    ];
  };

  # Enable direnv and nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Gate";
    userEmail = "simon@kampgate.se";
    diff-so-fancy.enable = true;
    includes = [
      {
        condition = "hasconfig:remote.*.url:git@gitlab.com:readly-ab/**";
        contents = {
          user = {
            email = "simon.gate@readly.com";
          };
        };
      }
    ];
    ignores = [
      ".direnv"
      "tmp"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      lfs.enable = true;
    };
  };

  programs.awscli = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "ansi";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
      };
      "smgt-dev" = {
        host = "100.93.118.110";
      };
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

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    mouse = false;
    prefix = "C-a";
    aggressiveResize = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
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

      # Set the current working directory based on the current pane's current
      # working directory (if set; if not, use the pane's starting directory)
      # when creating # new windows and splits.
      bind-key c new-window -c '#{pane_current_path}'
      bind-key '"' split-window -c '#{pane_current_path}'
      bind-key % split-window -h -c '#{pane_current_path}'

      # Open the new session in the current directory
      bind-key S command-prompt "new-session -A -c '#{pane_current_path}' -s '%%'"

    '';
  };

  xdg.enable = true;

  xdg.configFile.nvim = {
    source = ../../../../neovim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;
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

  programs.go = {
    enable = true;
    goPrivate = [
      "gitlab.com/readly-ab"
      "buf.build/gen/go"
    ];
  };

  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      "vendor/"
      ".git/"
      "npm_modules"
      ".terraform"
    ];
  };

  programs.home-manager.enable = true;
}
