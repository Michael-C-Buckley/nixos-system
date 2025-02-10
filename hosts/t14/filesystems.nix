{...}: {
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/B227-3C56";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    "/" = {
      device = "rpool/root/nixos-2411";
      fsType = "zfs";
    };

    "/home" = {
      device = "rpool/root/home";
      fsType = "zfs";
    };

    "/nix" = {
      device = "rpool/root/nix";
      fsType = "zfs";
    };

    "/drives/xfs-pool" = {
      device = "/dev/disk/by-uuid/0e9f0e00-eca4-4d8f-a12f-7534b8939d9d";
      fsType = "xfs";
    };
    "/drives/ext4-pool" = {
      device = "/dev/disk/by-uuid/cdfdca97-9c34-41d6-9a7f-fa190c920088";
      fsType = "ext4";
    };

    # Bind mounts
    "/var/lib/libvirt" = {
      device = "/drives/xfs-pool/libvirt";
      fsType = "none";
      options = ["bind"];
    };
    "/var/lib/docker" = {
      device = "/drives/xfs-pool/docker";
      fsType = "none";
      options = ["bind"];
    };

    "/home/michael/Downloads" = {
      device = "/drives/ext4-pool/downloads";
      fsType = "none";
      options = ["bind"];
    };
    "/home/michael/Downloads/ISOs" = {
      device = "/drives/xfs-pool/downloads";
      fsType = "none";
      options = ["bind"];
    };
  };
}