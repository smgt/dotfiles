{
  modulesPath,
  inputs,
  config,
  ...
}: let
  hostName = "fly";
  secretspath = builtins.toString inputs.secrets;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware-configuration.nix
    ./disko.nix
  ];

  smgt.dev.enable = true;

  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = "${secretspath}/secrets.yml";
    secrets = {
      "environment/GITHUB_TOKEN" = {};
      "environment/GITLAB_TOKEN" = {};
      "environment/GITEA_TOKEN" = {};
      "environment/CACHIX_AUTH_TOKEN" = {};
      "environment/OP_AWS_ACCOUNT" = {};
      "environment/OP_SSH_ACCOUNT" = {};
    };
    templates."default.env" = {
      content = ''
        export GITHUB_TOKEN="${config.sops.placeholder."environment/GITHUB_TOKEN"}"
        export GITLAB_TOKEN="${config.sops.placeholder."environment/GITLAB_TOKEN"}"
        export GITEA_TOKEN="${config.sops.placeholder."environment/GITEA_TOKEN"}"
        export CACHIX_AUTH_TOKEN="${config.sops.placeholder."environment/CACHIX_AUTH_TOKEN"}"
        export OP_AWS_ACCOUNT="${config.sops.placeholder."environment/OP_AWS_ACCOUNT"}"
        export OP_SSH_ACCOUNT="${config.sops.placeholder."environment/OP_SSH_ACCOUNT"}"
      '';
      owner = config.users.users.simon.name;
    };
  };

  boot = {
    initrd = {
      # Add proxmox network interface driver
      availableKernelModules = ["virtio_pci"];
      # Enable network during boot
      network = {
        enable = true;
        # To unlock the LUKS device remote using SSH
        ssh = {
          enable = true;
          port = 2222;
          authorizedKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZ0nP0eninWhJL29YmcyRo9Z09L/J518HppxTdt0AnD yam"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4Oka+Y67A+5hCIKX3ZAuWra407WWQKocd5Djl/AD5x sugarsnap"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYMEc/iU8oLrAse2Z3h5Xq7eZPSalLByghFtE5ETwnI paprika"
          ];
          # Host key to add to initrd
          hostKeys = [
            "/etc/ssh/ssh_host_ed25519_key"
          ];
          shell = "/bin/cryptsetup-askpass";
        };
      };
    };

    kernelParams = [
      "net.ifnames=0" # known interface names like eth0
      "ip=dhcp" # get ip from DHCP
    ];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  environment = {
    variables.HOSTNAME = hostName;
  };

  networking = {
    inherit hostName;
    firewall.enable = false;

    useNetworkd = true;

    nameservers = [
      "10.68.14.1"
      "100.100.100.100"
    ];
    defaultGateway = {
      address = "10.68.14.1";
      interface = "eth0";
    };
    interfaces.eth0.ipv4.addresses = [
      {
        address = "10.68.14.7";
        prefixLength = 23;
      }
    ];
  };

  systemd = {
    network.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["simon"];
        PermitRootLogin = "no";
      };
    };
    resolved = {
      enable = true;
      domains = [
        "kaga.se"
        "zebu-yo.ts.net"
      ];
      extraConfig = ''
        # Required to make e.g. 'ping myStrom-Switch-A46FD0' work
        ResolveUnicastSingleLabel=yes

        DNSStubListener=yes
      '';
    };
  };
  system.stateVersion = "25.11";
}
