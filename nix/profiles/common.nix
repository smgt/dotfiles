{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    coreutils-prefixed
    _1password
    bat
    curl
    dfc
    fd
    file
    fzf
    gcc
    gdb
    gitAndTools.gitFull
    go
    gnumake
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
    neovim
    nodejs_21
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
      LC_CTYPE = "en_US.UTF-8";
    };
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  # Set zsh as default shell
  users.defaultUserShell = pkgs.zsh;
  programs = {
    zsh = {
      enable = true;
    };
  };
}
