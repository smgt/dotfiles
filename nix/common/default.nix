{ config, lib, pkgs, ... }:
let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in with lib; {
  imports = [ ./users ];

  options.smgt = { gui.enable = mkEnableOption "Enable GUI programs"; };

  config = {
    programs = {
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
        allowed-users = [
          "simon"
        ];
        experimental-features = ["nix-command" "flakes"];
      };
      optimise = {
        automatic = true;
        dates = [ "01:32" ];
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
      _1password
      bash
      btop
      # rocmPackages.rocm-smi # amd gpu status
      bat
      curl
      charm-freeze
      delta
      difftastic
      dfc
      dig
      eva
      fd
      file
      fzf
      gcc
      gdb
      gitAndTools.gitFull
      go
      gotools
      gnumake
      gum
      htop
      iftop
      inetutils
      inotify-tools
      iotop
      jq
      killall
      libgcc
      lsof
      lz4
      moreutils
      mosh
      unstable.neovim
      nodejs_22
      perl
      pv
      pwgen
      python3
      ripgrep
      rsync
      ruby
      rustc
      cargo
      siege
      strace
      silver-searcher
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
      builtins.elem (lib.getName pkg) [ "1password-cli" "terraform" ];
  };

}
