{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.telegraf
  ];

  services.telegraf = {
    enable = true;
    extraConfig = {
      outputs = {
        prometheus_client = {
          listen = ":9273";
          path = "/metrics";
          metric_version = 2;
        };
      };
      inputs = {
        cpu = {
          percpu = true;
          totalcpu = true;
          collect_cpu_time = false;
          report_active = false;
        };
        disk = {
          ignore_fs = [
            "tmpfs"
            "devtmpfs"
            "devfs"
            "iso9660"
            "overlay"
            "aufs"
            "squashfs"
          ];
        };
      };
    };
  };
}
