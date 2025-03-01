# T14 Laptop Configuration

{inputs, ...}: let 
  inherit (inputs.nix-secrets.nixosModules) t14;
in {
  system.stateVersion = "24.11";

  imports = [
    t14
    ./networking
    ./systemd
    ./filesystems.nix
    ./hardware-configuration.nix
  ];

  custom.zfs.encryption = true;

  features = {
    cosmic = true;
    gaming = false;
  };

  services = {
    ucodenix = {
      enable = true;
      cpuModelId = "00A50F00";
    };
  };
}
