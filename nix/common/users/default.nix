{ config, pkgs, ... }:

{
  users = {
    users.simon = {
      isNormalUser = true;
      initialPassword = "pw123";
      extraGroups = [ "wheel" "docker" "audio" "plugdb" "libvirtd" "dialout" ]; # Enable `sudo` for the user.
      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+sxYLFUyDMdOUSax4E5zsshbWtVhOOxJnMeIezhaw/ simon@elli"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvWEz/NePRXK1BTGU6zbr3ASlQTtqFwT8sEvWgj09ly simon@kale"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAINn48B6XiiLpbupjUtmz2Puh3FXhAEBW4PqmqCXhBJv+AAAABHNzaDo= simon@kale"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYMEc/iU8oLrAse2Z3h5Xq7eZPSalLByghFtE5ETwnI simon@paprika"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4Oka+Y67A+5hCIKX3ZAuWra407WWQKocd5Djl/AD5x simon@sugarsnap"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWR9PLHWl96IzTyEcql1WE1sd3K2gEBVaIAWBCm71E9 fjotton"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTcbcxjbrvVWrnUlJSxCNT/O2Zg7HOR6Ne7RsP2PEhf tick"
      ];
    };

    users.root = {
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = config.users.users.simon.openssh.authorizedKeys.keys;
    };
  };

  security.sudo.extraRules = [
    {
      users = [ "simon" ];
      commands = [
        { command = "ALL"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];
}

