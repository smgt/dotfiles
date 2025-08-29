{osConfig, ...}: let
  cfg = osConfig.smgt.desktop;
in {
  services.darkman = {
    inherit (cfg) enable;
    settings = {
      dbusserver = true;
      usegeoclue = false;
    };
    lightModeScripts = {
      notify = ''
        notify-send --app-name="darkman" --urgency=low --icon=weather-clear "light mode"
      '';
      gnome = ''
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita
        gsettings set org.gnome.desktop.interface color-scheme prefer-light
      '';
      xsettings = ''
        exec xfconf-query -c xsettings -p /Net/ThemeName -s 'Adawaita'
      '';
    };
    darkModeScripts = {
      notify = ''
        notify-send --app-name="darkman" --urgency=low --icon=weather-clear-night "dark mode"
      '';
      gnome = ''
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
      '';
      xsettings = ''
        exec xfconf-query -c xsettings -p /Net/ThemeName -s 'Adawaita-dark'
      '';
    };
  };
}
