{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.tailscale
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  # Enable ip forwarding to allow tailscale routes
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
