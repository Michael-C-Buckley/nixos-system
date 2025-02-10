{ config, lib, modulesPath, inputs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.ucodenix.nixosModules.default
  ];

  boot = {
    kernelModules = [ "kvm" "kvm-amd" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "uas" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };

  hardware = {
    intel-gpu-tools.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services.ucodenix = {
    enable = true;
    cpuModelId = "00A20F12";
  };

  swapDevices = [ ];
}
