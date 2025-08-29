{
  config,
  pkgs,
  ...
}: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  i18n.supportedLocales = [
    "sv_SE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  boot.kernelParams = ["net.ifnames=0"];

  security.sudo.wheelNeedsPassword = false;
  users.users.simon = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvWEz/NePRXK1BTGU6zbr3ASlQTtqFwT8sEvWgj09ly kale"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINn48B6XiiLpbupjUtmz2Puh3FXhAEBW4PqmqCXhBJv+AAAABHNzaDo= kale"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4Oka+Y67A+5hCIKX3ZAuWra407WWQKocd5Djl/AD5x sugarsnap"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIONmyeOlgC1He22J+/LRCYA0A/cMUp2BK1oh9tixnHP+AAAABHNzaDo= sugarsnap"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWR9PLHWl96IzTyEcql1WE1sd3K2gEBVaIAWBCm71E9 fjotton"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTcbcxjbrvVWrnUlJSxCNT/O2Zg7HOR6Ne7RsP2PEhf tick"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYMEc/iU8oLrAse2Z3h5Xq7eZPSalLByghFtE5ETwnI paprika"
    ];

    isNormalUser = true;
    description = "Simon Gate";
    extraGroups = ["wheel"];
    initialPassword = "pw123"; # random for this post
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    zsh
    vim
    wget
    curl
    rxvt-unicode # for terminfo
    lshw
  ];

  programs.zsh.enable = true;
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
