_: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["simon"];
      PermitRootLogin = "no";
    };
  };
}
