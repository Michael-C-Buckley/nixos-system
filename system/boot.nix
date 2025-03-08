{stablePkgs, lib, ...}: {
  boot = {
    kernelPackages = lib.mkDefault stablePkgs.linuxKernel.packages.linux_xanmod;
    loader = {
      grub.enable = false;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
      };
    };
  };
}
