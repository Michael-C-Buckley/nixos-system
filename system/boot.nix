{pkgs, lib, ...}: {
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_xanmod_latest;
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
