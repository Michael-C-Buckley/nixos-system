# T14 Laptop Configuration

{inputs, ...}: {
  system.stateVersion = "24.11";

  imports = [
    inputs.nix-secrets.nixosModules.t14
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

  networking.hostId = "8425e349";

  services = {
    ucodenix = {
      enable = true;
      cpuModelId = "00A50F00";
    };
  };
}
