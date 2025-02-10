{pkgs, lib, ...}: {
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_stable;
    loader = {
      grub.enable = false;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 4;
      };
    };
  };
}
