{...}: {
  imports = [
    ./frr.nix
  ];

  networking = {
    hostName = "t14";
    networkmanager.enable = true;

    firewall = {
      extraInputRules = ''
        ip protocol 89 accept comment "Allow OSPF"
      '';
      enable = true;
      allowPing = true;
    };
  };
}
