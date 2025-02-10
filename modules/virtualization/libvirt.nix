{config, pkgs, lib, ...}: let

  useVirt = config.features.virtualization.libvirt;
  ovmfList = [(pkgs.OVMF.override {
    secureBoot = true;
    tpmSupport = true;
  }).fd];

in {

  options.features.virtualization.libvirt = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable libvirt on the host.";
  };

  config = lib.mkIf useVirt {
    environment.systemPackages = with pkgs; [
      virt-viewer
      virt-manager
      tigervnc
    ];

    users.users = {
      michael.extraGroups = [ "kvm" ];
      shawn.extraGroups = [ "kvm" ];
      root.extraGroups = [ "kvm" ];
    };

    virtualisation.libvirtd = {
      enable = true;
      allowedBridges = ["br0"];
      parallelShutdown = 5;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = ovmfList;
        };
      };
    };
  };
}
