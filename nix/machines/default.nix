{
  lib,
  pkgs,
  input,
  ...
}: let
  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4Oka+Y67A+5hCIKX3ZAuWra407WWQKocd5Djl/AD5x sugarsnap"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIONmyeOlgC1He22J+/LRCYA0A/cMUp2BK1oh9tixnHP+AAAABHNzaDo= sugarsnap"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZ0nP0eninWhJL29YmcyRo9Z09L/J518HppxTdt0AnD yam"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINn48B6XiiLpbupjUtmz2Puh3FXhAEBW4PqmqCXhBJv+AAAABHNzaDo= yam"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWR9PLHWl96IzTyEcql1WE1sd3K2gEBVaIAWBCm71E9 fjotton"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTcbcxjbrvVWrnUlJSxCNT/O2Zg7HOR6Ne7RsP2PEhf tick"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYMEc/iU8oLrAse2Z3h5Xq7eZPSalLByghFtE5ETwnI paprika"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAGvbdiDZJxZWRHeel0jUQk+/AqAzeVOC8FmAUC1gJGE fly"
  ];
in
  with lib; {
    imports = [
      ../modules/dev
      ../modules/wayland
      ../modules/steam.nix
      ../modules/tailscale.nix
      ../modules/openssh.nix
    ];

    config = {
      users = {
        users.root = {
          shell = pkgs.zsh;
          openssh.authorizedKeys.keys = ssh_keys;
        };
        users.simon = {
          isNormalUser = true;
          initialPassword = "pw123";
          extraGroups = [
            "wheel"
            "docker"
            "audio"
            "plugdb"
            "libvirtd"
            "dialout"
            "networkmanager"
          ]; # Enable `sudo` for the user.
          shell = pkgs.zsh;
          openssh.authorizedKeys.keys = ssh_keys;
        };
      };

      security.sudo.extraRules = [
        {
          users = ["simon"];
          commands = [
            {
              command = "ALL";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];

      programs = {
        ssh = {
          enableAskPassword = true;
          startAgent = true;
        };
        zsh = {
          enable = true;
          setOptions = [
            "NO_BG_NICE" # don't nice background tasks
            "NO_HUP"
            "NO_LIST_BEEP"
            "LOCAL_OPTIONS" # allow functions to have local options
            "LOCAL_TRAPS" # allow functions to have local traps
            "HIST_VERIFY"
            "EXTENDED_HISTORY" # add timestamps to history
            "PROMPT_SUBST"
            "COMPLETE_IN_WORD"
            "IGNORE_EOF"

            # Share history between sessions
            "APPEND_HISTORY" # adds history
            "INC_APPEND_HISTORY"
            "SHARE_HISTORY" # adds history incrementally and share it across sessions
            "HIST_REDUCE_BLANKS"
          ];
        };
      };

      nix = {
        settings = {
          allowed-users = ["simon"];
          trusted-users = ["simon"];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          # Add nixcache.kampgate.dev as cache
          substituters = [
            "https://nixcache.kampgate.dev"
            "https://nixpkgs-terraform.cachix.org"
          ];
          trusted-public-keys = [
            "nixcache.kampgate.dev:DQXzXiOJhIGMvYliX7gYD2VcQBcq2ArakAuuWhbsLv4="
            "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw="
          ];
        };
        optimise = {
          automatic = true;
          dates = ["01:32"];
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };
      };

      time.timeZone = "Europe/Stockholm";

      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_TIME = "sv_SE.UTF-8";
          LC_CTYPE = "en_US.UTF-8";
        };
      };

      environment.systemPackages = with pkgs; [
        coreutils-prefixed
        asn
        age
        _1password-cli
        bash
        btop
        # rocmPackages.rocm-smi # amd gpu status
        bat
        curl
        charm-freeze
        cachix
        delta
        difftastic
        dfc
        dig
        eva
        fd
        file
        fzf
        gitMinimal
        gum
        htop
        iftop
        inetutils
        inotify-tools
        iotop
        jq
        killall
        libfido2
        lsof
        lz4
        moreutils
        mosh
        neovim
        pv
        pwgen
        pinentry-tty
        qrencode
        ripgrep
        rsync
        strace
        silver-searcher
        ssh-to-age
        sops
        tcpdump
        tig
        tmux
        tree
        unzip
        vim
        wget
        whois
        yq
        zip
        zsh
      ];

      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "1password-cli"
          "terraform"
        ];
    };
  }
