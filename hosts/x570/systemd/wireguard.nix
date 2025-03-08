{config, pkgs, lib, inputs, ... }: let 
  wireguardInterface = inputs.nixos-modules.nixosModules.wireguard-interface {inherit config pkgs lib;};
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