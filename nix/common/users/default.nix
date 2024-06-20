{ config, pkgs, ... }:

{
  users.users.simon = {
    isNormalUser = true;
    initialPassword = "pw123";
    extraGroups = [ "wheel" "docker" "audio" "plugdb" "libvirtd" "dialout" ]; # Enable `sudo` for the user.
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+sxYLFUyDMdOUSax4E5zsshbWtVhOOxJnMeIezhaw/ simon@elli"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvWEz/NePRXK1BTGU6zbr3ASlQTtqFwT8sEvWgj09ly simon@kale"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYMEc/iU8oLrAse2Z3h5Xq7eZPSalLByghFtE5ETwnI simon@paprika"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4Oka+Y67A+5hCIKX3ZAuWra407WWQKocd5Djl/AD5x simon@sugarsnap"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWR9PLHWl96IzTyEcql1WE1sd3K2gEBVaIAWBCm71E9 fjotton"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.simon.openssh.authorizedKeys.keys;
  users.users.root.shell = pkgs.zsh;
}
