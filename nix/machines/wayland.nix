{pkgs, ...}: {
  programs = {
    thunderbird.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["simon"];
    };
    seahorse.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        wf-recorder
        mako # notification daemon
        grim
        kanshi
        slurp
        wezterm
        wofi
        light
        pavucontrol
      ];
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
      '';
    };
    light.enable = true;
  };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      kdePackages.xdg-desktop-portal-kde
    ];
    enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      iosevka-bin
      nerd-fonts.iosevka-term
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      mako # notification system developed by swaywm maintainer
      waybar
      iosevka-bin
      nerd-fonts.iosevka-term
      firefox
      wdisplays
      adwaita-icon-theme
      glib
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-wlr
      pulseaudio
      libnotify
      ncspot
      zed-editor
      libreoffice-qt
      hunspell
      hunspellDicts.sv_SE
      hunspellDicts.en_US
    ];

    etc."greetd/environments".text = ''
      sway
      zsh
    '';
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services = {
    gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = false;
    };
    greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd sway
        '';
      };
    };
    pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment the following
      #jack.enable = true;
    };
    flatpak = {
      enable = true;
      packages = [
        "com.slack.Slack"
        "com.discordapp.Discord"
        "com.mongodb.Compass"
        "com.spotify.Client"
        "org.flameshot.Flameshot"
        "org.signal.Signal"
        "com.github.tchx84.Flatseal"
        "io.dbeaver.DBeaverCommunity"
      ];
    };
    actkbd = {
      enable = true;
      bindings = [
        {
          keys = [225];
          events = ["key"];
          command = "/run/current-system/sw/bin/light -A 10";
        }
        {
          keys = [224];
          events = ["key"];
          command = "/run/current-system/sw/bin/light -U 10";
        }
      ];
    };
  };
}
