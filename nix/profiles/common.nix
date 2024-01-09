{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password
    curl
    dfc
    fd
    file
    fzf
    gdb
    gitAndTools.gitFull
    htop
    iftop
    inetutils
    inotify-tools
    iotop
    jq
    killall
    lsof
    lz4
    moreutils
    neovim
    pv
    pwgen
    ripgrep
    rsync
    siege
    strace
    tcpdump
    tmux
    tree
    unzip
    wget
    whois
    yq
    zip
    zsh
  ];

   nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-cli"
   ];

  time.timeZone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;
 }
