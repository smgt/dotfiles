{lib, ...}: let
  btrfsopt = [
    "compress=zstd"
    "noatime"
    "ssd"
    "space_cache=v2"
    "user_subvol_rm_allowed"
  ];
in {
  disko.devices = {
    disk = {
      main = {
        device = lib.mkDefault "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "nixos";
                passwordFile = "/tmp/secret.key";
                #additionalKeyFiles = ["/nixos-enc.key"];
                extraFormatArgs = [
                  "--type luks1"
                  "--iter-time 1000"
                ];
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "nixos"
                    "-f"
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = btrfsopt;
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = btrfsopt;
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = btrfsopt;
                    };
                    "/log" = {
                      mountpoint = "/var/log";
                      mountOptions = btrfsopt;
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
