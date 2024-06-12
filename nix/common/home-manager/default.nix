{ nixosConfig, pkgs, ... }:
{
  home.stateVersion = nixosConfig.system.stateVersion;

  services = {
    ssh-agent.enable = true;
  };
}
