{config, pkgs, lib, ...}: let
  useIncus = config.features.virtualization.incus;
in {
  options.features.virtualization.incus = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable incus on the host.";
  };

  config = lib.mkIf useIncus {
    # Incus requires nftables over iptables
    networking.nftables.enable =  true;
    services.lvm.boot.thin.enable = true;

    virtualisation = {
      incus = {
        package = pkgs.incus; # Do not use LTS
        enable = true;
        ui.enable = true;
        agent.enable = true;
      };
    };
  };
}
