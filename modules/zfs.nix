{config, pkgs, lib, ...}: {

  options.features.zfs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable ZFS features on host.";
    };
    encryption = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Request decryption credentials on boot.";
    };
  };

  config = {
    boot = {
      kernelModules = ["zfs"];
      supportedFilesystems = ["zfs"];
      zfs = {
        devNodes = "/dev/disk/by-partuuid";
        forceImportRoot = false;
        requestEncryptionCredentials = config.features.zfs.encryption;
      };
    };

    services.zfs.autoScrub.enable = true;

    environment.systemPackages = with pkgs; [
      zfs
    ];
  };
}
