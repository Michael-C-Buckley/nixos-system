{...}: let
  brAddr = {
    address = "192.168.48.10";
    prefixLength = 24;
  };
  brRoute = {
    address = "0.0.0.0";
    prefixLength = 0;
    via = "192.168.48.1";
  };
in {
  networking = {
    hostId = "007f0200";
    useDHCP = false;
    hostName = "x570";
    networkmanager.enable = true;
    usePredictableInterfaceNames = true;

    nameservers = [
      "192.168.48.1"
      "192.168.65.1"
    ];

    bridges.br0.interfaces = [ "enp8s0" ];
    interfaces = {
      # WIP: add default wifi to config
      wlp7s0.useDHCP = false;
      enp8s0.useDHCP = false;
      br0 = {
        wakeOnLan.enable = true;
        ipv4 = {
          addresses = [brAddr];
          routes = [brRoute];
        };
      };
    };
  };
}
