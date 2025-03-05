{config, pkgs, lib, ... }: let
  # WIP: This works to avoid having to define the lambda each time, but is still ugly
  wireguardInterface = import ../../../modules/wireguard-interface.nix { inherit config pkgs lib; };
in {
  systemd.services = {
    "wireguard-cary4" = wireguardInterface {
      name = "cary4";
      ipAddresses = ["192.168.78.2/27"];
    };
    "wireguard-creekstoneM4" = wireguardInterface {
      name = "creekstoneM4";
      ipAddresses = ["192.168.62.2/27"];
    };
  };
}