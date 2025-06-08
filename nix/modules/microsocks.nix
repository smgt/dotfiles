{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.microsocks
  ];

  services.microsocks = {
    enable = true;
    ip = "0.0.0.0";
  };

}
