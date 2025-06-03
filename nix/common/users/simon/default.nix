{ config, pkgs, lib, ... }:
let unstable = pkgs.unstable or pkgs;
in {
  imports = [ ./tmux.nix ];

  home = {
    sessionVariables = {
      DOTFILES = "$HOME/.dotfiles";
      GPG_TTY = "$(tty)";
      BAT_THEME = "ansi";
      PAGER = "less -R";
      MANPAGER = "nvim +Man!";
    };

    sessionPath =
      [ "$HOME/bin" "$DOTFILES/bin" "$HOME/go/bin" "$HOME/.local/bin" ];

    file = { ".terraformrc".source = ../../../config/terraform/terraformrc; };

    packages = [
      # Tooling
      pkgs.entr
      pkgs.buf
      pkgs.docker-compose
      pkgs.tig
      pkgs.git-lfs
      pkgs.dive
      pkgs.passage
      pkgs.difftastic
      pkgs.glab
      pkgs.fx
      pkgs.jq
      # Language servers
      pkgs.yaml-language-server
      pkgs.vscode-langservers-extracted
      pkgs.gopls
      pkgs.harper
      pkgs.terraform-ls
      pkgs.nil
      pkgs.rust-analyzer
      # Linters
      pkgs.nixd
      pkgs.hadolint
      pkgs.golangci-lint
      pkgs.checkmate
      pkgs.write-good
      pkgs.statix
      pkgs.semgrep
      pkgs.gosec
      pkgs.revive
      pkgs.checkmate
      pkgs.clippy
      # Formatters
      pkgs.gofumpt
      pkgs.gotools
      pkgs.hclfmt
      pkgs.nixfmt-rfc-style
      # Go
      pkgs.delve
      pkgs.impl
      pkgs.govulncheck
      pkgs.gomodifytags
      pkgs.gotestsum
      # Other
      pkgs.asn
    ];
  };

  xdg.enable = true;
  services = { ssh-agent.enable = true; };

  programs = {
    # xdg.configFile.nvim = {
    #   source = ../../../../neovim;
    #   recursive = true;
    # };

    btop = { enable = true; };

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
      lfs.enable = true;
      #diff-so-fancy.enable = true;
      # difftastic.enable = true;
      includes = [{
        condition = "hasconfig:remote.*.url:git@gitlab.com:readly-ab/**";
        contents = { user = { email = "simon.gate@readly.com"; }; };
      }];
      ignores =
        [ ".direnv" "tmp" ".DS_Store" "*.swp" ".env" "coverage.out" ".aider*" ];
      aliases = {
        dlog = "-c diff.external=difft log --ext-diff";
        dshow = "-c diff.external=difft show --ext-diff";
        ddiff = "-c diff.external=difft diff";
      };
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
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
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
        "*.dev.readly.com !nat.dev.readly.com" = {
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
          {
            name = "chrissicool/zsh-256color";
          }
          #{ name = "jeffreytse/zsh-vi-mode"; }
          #{ name = "zsh-users/zsh-autosuggestions"; }
          {
            name = "plugins/git";
            tags = [ "from:oh-my-zsh" ];
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
        fpath=($DOTFILES/zsh/prompts $fpath)
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
      ignores = [ "vendor/" ".git/" "npm_modules" ".terraform" ".direnv" ];
    };

    ripgrep = {
      enable = true;
      arguments = [ "--glob=!git/*" "--glob=!vendor/*" "--smart-case" ];
    };

    home-manager.enable = true;
  };
}
