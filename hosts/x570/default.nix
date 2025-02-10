# X570 Desktop Configuration

{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
    ./networking.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.05";

  features = {
    gaming = true;
    virtualization.libvirt = true;
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
