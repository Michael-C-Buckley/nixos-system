{config, pkgs, lib, ... }: let 
  # WIP: This works to avoid having to define the lambda each time, but is still ugly
  wireguardInterface = import ../../../modules/wireguard-interface.nix { inherit config pkgs lib; };
in {
  systemd.services = {
    "wireguard-cary4" = wireguardInterface {
      name = "cary4";
      # Path because Agenix is currently not working on the desktop, this is the local file workaround
      cfgPath = "/etc/wireguard/wg-cary4.conf";
      ipAddresses = ["192.168.240.241/31"];
    };
  };
}