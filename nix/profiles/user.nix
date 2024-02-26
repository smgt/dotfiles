{ lib, config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simon = {
    isNormalUser = true;
    initialPassword = "pw123";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+sxYLFUyDMdOUSax4E5zsshbWtVhOOxJnMeIezhaw/ simon@elli"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvWEz/NePRXK1BTGU6zbr3ASlQTtqFwT8sEvWgj09ly simon@kale"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYMEc/iU8oLrAse2Z3h5Xq7eZPSalLByghFtE5ETwnI simon@paprika"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4Oka+Y67A+5hCIKX3ZAuWra407WWQKocd5Djl/AD5x simon@sugarsnap"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWR9PLHWl96IzTyEcql1WE1sd3K2gEBVaIAWBCm71E9 elvan"
    ];
    # environment.variables = {
    #   EDITOR = "nvim";
    # };
    packages = with pkgs; [
      nix-direnv
      direnv
      asdf-vm
    ];
  };


  home-manager.users.simon = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";

    home.sessionVariables = {
      DOTFILES = "$HOME/.dotfiles";
    };

    home.sessionPath = [
      "$HOME/bin"
      "$DOTFILES/bin"
    ];

    xdg.enable = true;

    xdg.configFile.zsh = {
      source = ../../zsh;
      recursive = true;
    };

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
      source = ../../neovim;
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
          { name = "zsh-users/zsh-autosuggestions"; }
          #{ name = "plugins/git"; from = "oh-my-zsh"; }
        ];
      };

      shellAliases = {
        grep = "grep --color";
        dotvim = "pushd $DOTFILES && $EDITOR . && popd";
        dotcd = "cd $DOTFILES";
        "...." = "cd ../../..";
        "..." = "cd ../..";
        ".." = "cd ..";
        "--" = "cd -";
        "_" = "sudo";
        v = "$EDITOR";
        n = "$EDITOR";
        ls = "ls -F --color";
        l = "ls -a --color";
        ll = "ls -lh --color";
        la = "ls -A --color";
      };
      sessionVariables = {
        BAT_THEME = "ansi";
        DOTFILES = "$HOME/.dotfiles";
        GPG_TTY = "$(tty)";
      };
      initExtra = ''
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
      '';
    };

      # programs.zsh = {
      #   enable = true;
      # };
    };


}
