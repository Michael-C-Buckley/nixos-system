# X570 Desktop Configuration

{inputs, pkgs, ...}: let
  nixMods = inputs.nixos-modules.nixosModules;
in {
  imports = with nixMods; [
    libvirt
    ./hardware-configuration.nix
    ./filesystems.nix
    ./networking.nix
  ];

  system.stateVersion = "24.05";

  features = {
    gaming = true;
  };

  custom.virtualisation.libvirt = {
    users = ["michael" "root"];
  };

  users.users.michael.packages = with pkgs; [
    ansible
    terraform
    terraform-ls
  ];

  environment.systemPackages = with pkgs; [
    gns3-gui
    gns3-server
  ];

  services = {
    gns3-server = {
      enable = true;
      ubridge.enable = true;
    };
  };
}
