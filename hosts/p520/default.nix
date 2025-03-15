# P520 Server Configuration
{inputs, pkgs, ...}: let
  ipAddress = "192.168.48.5";
  inherit (inputs.nixos-modules.nixosModules) nvidia libvirt;
in {
  system.stateVersion = "24.05";

  imports = [
    libvirt
    nvidia
    ./hardware-configuration.nix
    ./systemd
  ];

  boot = {
    extraModprobeConfig = "options kvm_intel nested=1";
    kernelPackages = pkgs.linuxKernel.packages.linux_hardened;
  };

  custom.virtualisation.libvirt = {
    users = ["michael" "root"];
  };

  programs.atop.atopgpu.enable = true;

  networking = {
    hostName = "p520";
    hostId = "181a3ead";

    # WIP: transition to resolved
    nameservers = [
      "1.1.1.1"
    ];

    bridges.br0.interfaces = ["eno1"];
    interfaces.br0.ipv4 = {
      routes = [{
        address = "0.0.0.0";
        prefixLength = 0;
        via = "192.168.48.102";
      }];

      addresses = [{
        address = ipAddress;
        prefixLength = 24;
      }];
    };
  };

}
