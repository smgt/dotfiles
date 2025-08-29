{inputs, ...}: {
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  secretspath = builtins.toString inputs.secrets;
  cfg = osConfig.smgt;
in {
  imports = [
    ./tmux.nix
    ./zsh.nix
    ./dev.nix
    ./syncthing.nix
    ./desktop
  ];

  # sops = {
  #   age.sshKeyPaths = ["${home.homeDirectory}/.ssh/id_ed25519"];
  #   defaultSopsFile = "${secretspath}/secrets.yml";
  # };
  # [[ -a ${config.sops.templates."default.env".path} ]] && source ${ config.sops.templates."default.env".path }
  config = {
    home = {
      username = "simon";
      homeDirectory = "/home/simon";
      sessionVariables = {
        DOTFILES = "$HOME/.dotfiles";
        GPG_TTY = "$(tty)";
        BAT_THEME = "ansi";
        PAGER = "less -R";
        MANPAGER = "nvim +Man!";
      };

      stateVersion = pkgs.lib.mkDefault "25.05";

      sessionPath = [
        "$HOME/bin"
        "$DOTFILES/bin"
        "$HOME/go/bin"
        "$HOME/.local/bin"
      ];

      file = {
        # TODO: Create the terraform plugin directory: /home/$USER/.terraform.d/plugin-cache
        ".terraformrc".source = ../config/terraform/terraformrc;
        "${config.xdg.configHome}/zsh/prompt_smgt_setup".source = ../../zsh/prompts/prompt_smgt_setup;
        ".local/bin/1p-ssh".source = ../../bin/1p-ssh;
        ".local/bin/1p-env".source = ../../bin/1p-env;
      };

      packages = with pkgs; [
        tig
        git-lfs
        dive
        passage
        difftastic
        fx
        jq
        jo
        qsv
        asn
      ];
    };

    xdg.enable = true;
    services = {
      ssh-agent.enable = true;
    };

    programs = {
      btop = {
        enable = true;
      };

      # Enable direnv and nix-direnv
      direnv = {
        inherit (cfg.dev) enable;
        nix-direnv.enable = true;
        enableZshIntegration = true;
        config = {
          global = {
            warn_timeout = "5m";
          };
        };
      };

      zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = ["--cmd cd"];
      };

      git = {
        enable = true;
        userName = "Simon Gate";
        userEmail = "simon@kampgate.se";
        lfs.enable = true;
        #diff-so-fancy.enable = true;
        # difftastic.enable = true;
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
          ".DS_Store"
          "*.swp"
          ".env"
          "coverage.out"
          ".aider*"
        ];
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
          color = {
            ui = "auto";
          };
          merge = {
            conflictstyle = "diff3";
          };
          fetch = {
            prune = true;
            pruneTags = true;
            all = true;
          };
        };
      };

      awscli = {
        inherit (cfg.dev) enable;
      };

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
          "*" = {
            forwardAgent = false;
          };
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

      go = {
        inherit (cfg.dev) enable;
        goPrivate = [
          "gitlab.com/readly-ab"
          "buf.build/gen/go"
        ];
      };

      fd = {
        enable = true;
        hidden = true;
        ignores = [
          "vendor/"
          ".git/"
          "npm_modules"
          ".terraform"
          ".direnv"
        ];
      };

      ripgrep = {
        enable = true;
        arguments = [
          "--glob=!git/*"
          "--glob=!vendor/*"
          "--smart-case"
        ];
      };

      home-manager.enable = true;
    };
  };
}
