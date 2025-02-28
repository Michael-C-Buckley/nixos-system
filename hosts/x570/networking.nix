{lib, ...}: {
  networking = {
    hostId = "007f0200";
    useDHCP = lib.mkForce true;
    hostName = "x570";
    networkmanager.enable = true;
    usePredictableInterfaceNames = true;

    firewall = {
      extraInputRules = ''
        ip protocol 89 accept comment "Allow OSPF"
      '';
    };

    bridges.br0.interfaces = [];
    interfaces = {
      lo.ipv4.addresses = [{
        address = "192.168.63.10"; prefixLength = 32;
      }];
    };
  };
}
