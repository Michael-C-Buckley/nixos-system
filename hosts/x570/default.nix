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
    alacritty # For the consoles for GNS nodes, for now, may change later
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
