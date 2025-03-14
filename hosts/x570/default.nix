# X570 Desktop Configuration

{inputs, pkgs, ...}: let
  nixMods = inputs.nixos-modules.nixosModules;
in {
  imports = with nixMods; [
    inputs.nix-secrets.nixosModules.x570
    libvirt
    ./systemd
    ./filesystems.nix
    ./frr.nix
    ./hardware-configuration.nix
    ./networking.nix
  ];

  system.stateVersion = "24.05";

  features = {
    autoLogin = true; # Only if not on Ly
    displayManager = "sddm";
    cosmic = true;
    gaming = true;
  };

  custom.virtualisation = {
    gns3.enable = true;
    libvirt.users = ["michael" "root"];
  };

  users.users.michael.packages = with pkgs; [
    ansible
    terraform
    terraform-ls
  ];
}
