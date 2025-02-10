{...}: {
  imports = [
    ./frr.nix
  ];

  networking = {
    hostName = "t14";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowPing = true;
    };
  };
}
